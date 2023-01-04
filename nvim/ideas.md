IDEAS
=====

# MINI:
 - Tags

# Auto-renaming identifier nodes
  Essentially, I want to be able to do a `ciw` on an identifier node IFF its the definition, and have all other
  references to that node auto-update. This should also work in insert mode.

  - https://github.com/nvim-treesitter/nvim-treesitter-refactor/blob/master/lua/nvim-treesitter-refactor/smart_rename.lua
  - https://github.com/windwp/nvim-ts-autotag/blob/main/lua/nvim-ts-autotag/internal.lua


# Plugins to check out
  - https://github.com/akinsho/git-conflict.nvim
  - https://github.com/rktjmp/lush.nvim
  - https://github.com/andythigpen/nvim-coverage
  - https://github.com/fitrh/init.nvim/blob/main/lua/config/plugin/cmp/setup.lua
  - https://github.com/kylechui/nvim-surround

ISSUES
======

# NeoTree
  - rename textbox is in dumb place
  - logging needs to be supressed, I don't wanna see confirmations of what happened
  - pasting items changes position of list view
  - rename dialogue box takes focus and changes background color

# LuaSnip
  - Function Snips (init ruby) adds text to first line in buffer randomly
  - ERB: html tag needs to handle comment tags

# Neotest
  - integrate with quickfix
