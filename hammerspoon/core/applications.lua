local M = {}

local hyper = { "cmd", "shift" }
local log = hs.logger.new("hammerspoon", "debug")

-- That fzf like splits thing by evan travers
-- https://github.com/evantravers/hammerspoon-config/blob/38a7d8c0ad2190d1563d681725628e4399dcbe6c/movewindows.lua

-- NO animations, switching should be instant

-- Get bundle ID:
-- osascript -e 'id of app "<app name>"'

local apps = {
	["Kitty"] = {
		bundleID = "net.kovidgoyal.kitty",
		launch_key = "i",
	},
	["Slack"] = {
		bundleID = "com.tinyspeck.slackmacgap",
		launch_key = "s",
	},
	["Finder"] = {
		bundleID = "com.apple.finder",
		launch_key = "f",
	},
	["Firefox"] = {
		-- bundleID = "com.google.Chrome",
		bundleID = "org.mozilla.firefoxdeveloperedition",
		launch_key = "w",
	},
}

function M.load()
	for name, config in pairs(apps) do
		hs.hotkey.bind(hyper, config.launch_key, function()
			M.open(name)
		end)
	end

	return M
end

function M.open(name)
	-- log.i("> Launching App: " .. name)
	hs.application.launchOrFocus(name)
end

return M
