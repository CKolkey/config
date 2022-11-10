-- https://github.com/justintanner/universal-emacs-keybindings/blob/master/emacs_hammerspoon.lua

local M = {}

local hotkeyModal = hs.hotkey.modal.new()

local function feedKeys(mods, key)
  hotkeyModal:exit()
  hs.eventtap.event.newKeyEvent(mods, key, true):post()
  hs.eventtap.event.newKeyEvent(mods, key, false):post()
  hotkeyModal:enter()
end

local keys = {
  ['global'] = {
    ['ctrl'] = {
      ['n'] = { key = 'down' },
      ['p'] = { key = 'up' },
      ['r'] = { mods = { 'cmd' }, key = 'f' },
      ['f'] = { mods = { 'alt' }, key = 'right' },
      ['b'] = { mods = { 'alt' }, key = 'left' },
      ['w'] = { macro = 'backwardsKillWord' },
      ['e'] = { macro = 'forwardsKillWord' },
    },
  },
}

local macros = {
  backwardsKillWord = function()
    feedKeys({ 'shift', 'alt' }, 'left')
    feedKeys('cmd', 'x')
  end,

  forwardsKillWord = function()
    feedKeys({ 'shift', 'alt' }, 'right')
    feedKeys('cmd', 'x')
  end,
}

local blacklist = {
  'kitty'
}

local function callBinding(namespace, mods, key)
  local binding = keys[namespace][mods][key]

  if binding.macro then
    macros[binding.macro]()
  else
    feedKeys(binding.mods or {}, binding.key)
  end
end

local function keybindingExists(namespace, mods, key)
  return (keys[namespace] ~= nil and keys[namespace][mods] ~= nil and keys[namespace][mods][key] ~= nil)
end

local function currentApp()
  local app = hs.application.frontmostApplication()
  if app ~= nil then
    return app:title()
  end
end

local function appIsBlacklisted()
  for _, value in ipairs(blacklist) do
    if value:lower() == currentApp():lower() then
      return true
    end
  end

  return false
end

local function currentNamespace(mods, key)
  if currentApp() and keybindingExists(currentApp(), mods, key) then
    return currentApp()
  else
    return 'global'
  end
end

local function processKeystrokes(mods, key)
  return function()
    local namespace = currentNamespace(mods, key)
    if not appIsBlacklisted() and keybindingExists(namespace, mods, key) then
      callBinding(namespace, mods, key)
    else
      feedKeys(mods, key)
    end
  end
end

M.load = function()
  for namespace, modTable in pairs(keys) do
    for mod, keyTable in pairs(modTable) do
      for key, keyConfig in pairs(keyTable) do
        hotkeyModal:bind(mod, key, processKeystrokes(mod, key), nil, nil)
      end
    end
  end

  hotkeyModal:enter()

  return M
end

return M
