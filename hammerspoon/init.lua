require("lib.os")

hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

hs.window.animationDuration = 0.1

WindowMotions = require("core.window_motions").load()
Appliations   = require("core.applications").load()
CopyOnSelect  = require("core.copy_on_select").load()
Keybindings   = require("core.keybindings").load()

require("console").init()
