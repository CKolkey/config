IDEAS
=====

# MINI:
 - Tags
 - Align

# Auto-renaming identifier nodes
  Essentially, I want to be able to do a `ciw` on an identifier node IFF its the definition, and have all other
  references to that node auto-update. This should also work in insert mode.

  - https://github.com/nvim-treesitter/nvim-treesitter-refactor/blob/master/lua/nvim-treesitter-refactor/smart_rename.lua
  - https://github.com/windwp/nvim-ts-autotag/blob/main/lua/nvim-ts-autotag/internal.lua

# Use LuaSnip and Treesitter to create fast RSPEC templates

# Treesitter NodeActions
  Expand and Collapse container type nodes
  - https://github.com/AckslD/nvim-trevJ.lua/blob/main/lua/trevj.lua

  Cycle through identifier cases
  - https://github.com/bhritchie/vim-toggle-case/blob/master/plugin/toggle-case.vim

  toggle if statements between terniarys and back

  ruby: if <-> unless

# Plugins to check out
  - https://github.com/akinsho/git-conflict.nvim
  - https://github.com/rktjmp/lush.nvim
  - https://github.com/andythigpen/nvim-coverage
  - https://github.com/fitrh/init.nvim/blob/main/lua/config/plugin/cmp/setup.lua
  - https://github.com/kylechui/nvim-surround


## Constants
  - Extract

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
