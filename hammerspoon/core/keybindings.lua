-- https://github.com/justintanner/universal-emacs-keybindings/blob/master/emacs_hammerspoon.lua

local M = {}

local hotkeyModal = hs.hotkey.modal.new()

local function feedKeys(mods, key)
  if not key then return end

  hotkeyModal:exit()
  hs.eventtap.event.newKeyEvent(mods, key, true):post()
  hs.eventtap.event.newKeyEvent(mods, key, false):post()
  hotkeyModal:enter()
end

local keys = {
  ['kitty'] = {
    [''] = { -- Remap keys with no modifier
      ["§"] = { key = "`" },
      -- ["±"] = { key = "~" }
    },
  },
  ['global'] = {
    [''] = { -- Remap keys with no modifier
      ["§"] = { key = "`" }
    },
    ['ctrl'] = {
      ['n'] = { key = 'down' },
      ['p'] = { key = 'up' },
      ['r'] = { mods = { 'cmd' }, key = 'f' },
      ['y'] = { mods = { 'cmd' }, key = 'c' },
      ['w'] = { macro = 'backwardsKillWord' },
      ['d'] = { macro = 'forwardsKillWord' },
      ['f'] = { mods = { 'shift', 'alt' }, key = 'right' },
      ['b'] = { mods = { 'shift', 'alt' }, key = 'left' },
    },
    ['alt'] = {
      ['b'] = { mods = { 'alt' }, key = 'left' },
      ['f'] = { mods = { 'alt' }, key = 'right' },
    }
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
  return (keys[namespace] and keys[namespace][mods] and keys[namespace][mods][key])
end

local function currentApp()
  local app = hs.application.frontmostApplication()
  if app then
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

local function bindingPermittedInApp(namespace)
  return (namespace == 'global' and not appIsBlacklisted()) or namespace ~= 'global'
end

local function processKeystrokes(mods, key)
  return function()
    local namespace = currentNamespace(mods, key)
    if keybindingExists(namespace, mods, key) and bindingPermittedInApp(namespace) then
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
