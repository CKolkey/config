-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = true
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/u0158204/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/u0158204/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/u0158204/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/u0158204/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/u0158204/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["FixCursorHold.nvim"] = {
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/FixCursorHold.nvim",
    url = "https://github.com/antoinemadec/FixCursorHold.nvim"
  },
  LuaSnip = {
    config = { 'require("plugins/_luasnip").config()' },
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["auto-save.nvim"] = {
    config = { 'require("plugins/_autosave").config()' },
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/auto-save.nvim",
    url = "https://github.com/Pocco81/auto-save.nvim"
  },
  ["auto-session"] = {
    config = { 'require("plugins/_autosession").config()' },
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/auto-session",
    url = "https://github.com/rmagatti/auto-session"
  },
  ["bufferline.nvim"] = {
    config = { 'require("plugins/_bufferline").config()' },
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/bufferline.nvim",
    url = "https://github.com/akinsho/bufferline.nvim"
  },
  ["cmd-parser.nvim"] = {
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/cmd-parser.nvim",
    url = "https://github.com/winston0410/cmd-parser.nvim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-fuzzy-buffer"] = {
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/cmp-fuzzy-buffer",
    url = "https://github.com/tzachar/cmp-fuzzy-buffer"
  },
  ["cmp-fuzzy-path"] = {
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/cmp-fuzzy-path",
    url = "https://github.com/tzachar/cmp-fuzzy-path"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-lsp-document-symbol"] = {
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp-document-symbol",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp-document-symbol"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  ["cmp-rg"] = {
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/cmp-rg",
    url = "https://github.com/lukas-reineke/cmp-rg"
  },
  ["cmp-tabnine"] = {
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/cmp-tabnine",
    url = "https://github.com/tzachar/cmp-tabnine"
  },
  ["cmp-treesitter"] = {
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/cmp-treesitter",
    url = "https://github.com/ray-x/cmp-treesitter"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["diffview.nvim"] = {
    config = { 'require("plugins/_diffview").config()' },
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/diffview.nvim",
    url = "https://github.com/sindrets/diffview.nvim"
  },
  ["dressing.nvim"] = {
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/dressing.nvim",
    url = "https://github.com/stevearc/dressing.nvim"
  },
  ["editorconfig.nvim"] = {
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/editorconfig.nvim",
    url = "https://github.com/gpanders/editorconfig.nvim"
  },
  ["fuzzy.nvim"] = {
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/fuzzy.nvim",
    url = "https://github.com/tzachar/fuzzy.nvim"
  },
  ["gitsigns.nvim"] = {
    config = { 'require("plugins/_gitsigns").config()' },
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["guess-indent.nvim"] = {
    config = { 'require("plugins/_guess_indent").config()' },
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/guess-indent.nvim",
    url = "https://github.com/nmac427/guess-indent.nvim"
  },
  harpoon = {
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/harpoon",
    url = "https://github.com/ThePrimeagen/harpoon"
  },
  ["impatient.nvim"] = {
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/impatient.nvim",
    url = "https://github.com/lewis6991/impatient.nvim"
  },
  ["indent-blankline.nvim"] = {
    config = { 'require("plugins/_indent_blankline").config()' },
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  ["leap.nvim"] = {
    config = { 'require("plugins/_leap").config()' },
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/leap.nvim",
    url = "https://github.com/ggandor/leap.nvim"
  },
  ["lsp_signature.nvim"] = {
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/lsp_signature.nvim",
    url = "https://github.com/ray-x/lsp_signature.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/lspkind-nvim",
    url = "https://github.com/onsails/lspkind-nvim"
  },
  ["lualine.nvim"] = {
    config = { 'require("plugins/_lualine").config()' },
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["mini.nvim"] = {
    config = { 'require("plugins/_mini").config()' },
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/mini.nvim",
    url = "https://github.com/echasnovski/mini.nvim"
  },
  ["neo-tree.nvim"] = {
    config = { 'require("plugins/_neotree").config()' },
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/neo-tree.nvim",
    url = "https://github.com/nvim-neo-tree/neo-tree.nvim"
  },
  neogit = {
    config = { 'require("plugins/_neogit").config()' },
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/neogit",
    url = "https://github.com/TimUntersberger/neogit"
  },
  neotest = {
    config = { 'require("plugins/_neotest").config()' },
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/neotest",
    url = "https://github.com/nvim-neotest/neotest"
  },
  ["neotest-rspec"] = {
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/neotest-rspec",
    url = "https://github.com/olimorris/neotest-rspec"
  },
  ["nui.nvim"] = {
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/nui.nvim",
    url = "https://github.com/MunifTanjim/nui.nvim"
  },
  ["numb.nvim"] = {
    config = { 'require("plugins/_numb").config()' },
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/numb.nvim",
    url = "https://github.com/nacro90/numb.nvim"
  },
  ["nvim-autopairs"] = {
    config = { 'require("plugins/_autopairs").config()' },
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    config = { 'require("plugins/_completion").config()' },
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-colorizer.lua"] = {
    config = { 'require("plugins/_colorizer").config()' },
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua",
    url = "https://github.com/NvChad/nvim-colorizer.lua"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-nonicons"] = {
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/nvim-nonicons",
    url = "https://github.com/yamatsum/nvim-nonicons"
  },
  ["nvim-notify"] = {
    config = { 'require("plugins/_notifications").config()' },
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/nvim-notify",
    url = "https://github.com/rcarriga/nvim-notify"
  },
  ["nvim-pqf.git"] = {
    config = { 'require("plugins/_pretty_quickfix").config()' },
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/nvim-pqf.git",
    url = "https://gitlab.com/yorickpeterse/nvim-pqf"
  },
  ["nvim-treesitter"] = {
    config = { 'require("plugins/_treesitter").config()' },
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-context"] = {
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/nvim-treesitter-context",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-context"
  },
  ["nvim-treesitter-endwise"] = {
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/nvim-treesitter-endwise",
    url = "https://github.com/RRethy/nvim-treesitter-endwise"
  },
  ["nvim-treesitter-refactor"] = {
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/nvim-treesitter-refactor",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-refactor"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects"
  },
  ["nvim-trevJ.lua"] = {
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/nvim-trevJ.lua",
    url = "https://github.com/AckslD/nvim-trevJ.lua"
  },
  ["nvim-ts-autotag"] = {
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/nvim-ts-autotag",
    url = "https://github.com/windwp/nvim-ts-autotag"
  },
  ["nvim-ts-context-commentstring"] = {
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/nvim-ts-context-commentstring",
    url = "https://github.com/JoosepAlviste/nvim-ts-context-commentstring"
  },
  ["nvim-web-devicons"] = {
    config = { 'require("plugins/_devicons").config()' },
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["onedarkpro.nvim"] = {
    config = { 'require("plugins/_onedark").config()' },
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/onedarkpro.nvim",
    url = "https://github.com/olimorris/onedarkpro.nvim"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  playground = {
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/playground",
    url = "https://github.com/nvim-treesitter/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["pretty-fold.nvim"] = {
    config = { 'require("plugins/_prettyfold").config()' },
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/pretty-fold.nvim",
    url = "https://github.com/anuvyklack/pretty-fold.nvim"
  },
  ["qf_helper.nvim"] = {
    config = { 'require("plugins/_quickfix_helper").config()' },
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/qf_helper.nvim",
    url = "https://github.com/stevearc/qf_helper.nvim"
  },
  ["range-highlight.nvim"] = {
    config = { 'require("plugins/_range_highlight").config()' },
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/range-highlight.nvim",
    url = "https://github.com/winston0410/range-highlight.nvim"
  },
  ["remember.nvim"] = {
    config = { 'require("plugins/_remember").config()' },
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/remember.nvim",
    url = "https://github.com/vladdoster/remember.nvim"
  },
  ["scope.nvim"] = {
    config = { 'require("plugins/_scope").config()' },
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/scope.nvim",
    url = "https://github.com/tiagovla/scope.nvim"
  },
  ["smart-splits.nvim"] = {
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/smart-splits.nvim",
    url = "https://github.com/mrjones2014/smart-splits.nvim"
  },
  ["stabilize.nvim"] = {
    config = { 'require("plugins/_stabilize").config()' },
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/stabilize.nvim",
    url = "https://github.com/luukvbaal/stabilize.nvim"
  },
  ["substitute.nvim"] = {
    config = { 'require("plugins/_substitute").config()' },
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/substitute.nvim",
    url = "https://github.com/gbprod/substitute.nvim"
  },
  ["tabout.nvim"] = {
    config = { 'require("plugins/_tabout").config()' },
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/tabout.nvim",
    url = "https://github.com/abecodes/tabout.nvim"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim"
  },
  ["telescope-ui-select.nvim"] = {
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/telescope-ui-select.nvim",
    url = "https://github.com/nvim-telescope/telescope-ui-select.nvim"
  },
  ["telescope-zf-native.nvim"] = {
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/telescope-zf-native.nvim",
    url = "https://github.com/natecraddock/telescope-zf-native.nvim"
  },
  ["telescope.nvim"] = {
    config = { 'require("plugins/_telescope").config()' },
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["vim-bundler"] = {
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/vim-bundler",
    url = "https://github.com/tpope/vim-bundler"
  },
  ["vim-cool"] = {
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/vim-cool",
    url = "https://github.com/romainl/vim-cool"
  },
  ["vim-matchup"] = {
    after_files = { "/Users/u0158204/.local/share/nvim/site/pack/packer/opt/vim-matchup/after/plugin/matchit.vim" },
    loaded = true,
    needs_bufread = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/opt/vim-matchup",
    url = "https://github.com/andymass/vim-matchup"
  },
  ["vim-projectionist"] = {
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/vim-projectionist",
    url = "https://github.com/tpope/vim-projectionist"
  },
  ["vim-rails"] = {
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/vim-rails",
    url = "https://github.com/tpope/vim-rails"
  },
  ["vim-rake"] = {
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/vim-rake",
    url = "https://github.com/tpope/vim-rake"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/vim-repeat",
    url = "https://github.com/tpope/vim-repeat"
  },
  ["vim-sensible"] = {
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/vim-sensible",
    url = "https://github.com/tpope/vim-sensible"
  },
  ["vim-startuptime"] = {
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/vim-startuptime",
    url = "https://github.com/dstein64/vim-startuptime"
  },
  ["vim-wordmotion"] = {
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/vim-wordmotion",
    url = "https://github.com/chaoren/vim-wordmotion"
  },
  ["winshift.nvim"] = {
    loaded = true,
    path = "/Users/u0158204/.local/share/nvim/site/pack/packer/start/winshift.nvim",
    url = "https://github.com/sindrets/winshift.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Setup for: vim-matchup
time([[Setup for vim-matchup]], true)
require("plugins/_matchup").setup()
time([[Setup for vim-matchup]], false)
time([[packadd for vim-matchup]], true)
vim.cmd [[packadd vim-matchup]]
time([[packadd for vim-matchup]], false)
-- Config for: nvim-web-devicons
time([[Config for nvim-web-devicons]], true)
require("plugins/_devicons").config()
time([[Config for nvim-web-devicons]], false)
-- Config for: nvim-colorizer.lua
time([[Config for nvim-colorizer.lua]], true)
require("plugins/_colorizer").config()
time([[Config for nvim-colorizer.lua]], false)
-- Config for: neo-tree.nvim
time([[Config for neo-tree.nvim]], true)
require("plugins/_neotree").config()
time([[Config for neo-tree.nvim]], false)
-- Config for: bufferline.nvim
time([[Config for bufferline.nvim]], true)
require("plugins/_bufferline").config()
time([[Config for bufferline.nvim]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
require("plugins/_treesitter").config()
time([[Config for nvim-treesitter]], false)
-- Config for: tabout.nvim
time([[Config for tabout.nvim]], true)
require("plugins/_tabout").config()
time([[Config for tabout.nvim]], false)
-- Config for: nvim-autopairs
time([[Config for nvim-autopairs]], true)
require("plugins/_autopairs").config()
time([[Config for nvim-autopairs]], false)
-- Config for: guess-indent.nvim
time([[Config for guess-indent.nvim]], true)
require("plugins/_guess_indent").config()
time([[Config for guess-indent.nvim]], false)
-- Config for: substitute.nvim
time([[Config for substitute.nvim]], true)
require("plugins/_substitute").config()
time([[Config for substitute.nvim]], false)
-- Config for: numb.nvim
time([[Config for numb.nvim]], true)
require("plugins/_numb").config()
time([[Config for numb.nvim]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
require("plugins/_gitsigns").config()
time([[Config for gitsigns.nvim]], false)
-- Config for: stabilize.nvim
time([[Config for stabilize.nvim]], true)
require("plugins/_stabilize").config()
time([[Config for stabilize.nvim]], false)
-- Config for: scope.nvim
time([[Config for scope.nvim]], true)
require("plugins/_scope").config()
time([[Config for scope.nvim]], false)
-- Config for: auto-session
time([[Config for auto-session]], true)
require("plugins/_autosession").config()
time([[Config for auto-session]], false)
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
require("plugins/_completion").config()
time([[Config for nvim-cmp]], false)
-- Config for: remember.nvim
time([[Config for remember.nvim]], true)
require("plugins/_remember").config()
time([[Config for remember.nvim]], false)
-- Config for: nvim-pqf.git
time([[Config for nvim-pqf.git]], true)
require("plugins/_pretty_quickfix").config()
time([[Config for nvim-pqf.git]], false)
-- Config for: mini.nvim
time([[Config for mini.nvim]], true)
require("plugins/_mini").config()
time([[Config for mini.nvim]], false)
-- Config for: neogit
time([[Config for neogit]], true)
require("plugins/_neogit").config()
time([[Config for neogit]], false)
-- Config for: neotest
time([[Config for neotest]], true)
require("plugins/_neotest").config()
time([[Config for neotest]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
require("plugins/_lualine").config()
time([[Config for lualine.nvim]], false)
-- Config for: qf_helper.nvim
time([[Config for qf_helper.nvim]], true)
require("plugins/_quickfix_helper").config()
time([[Config for qf_helper.nvim]], false)
-- Config for: diffview.nvim
time([[Config for diffview.nvim]], true)
require("plugins/_diffview").config()
time([[Config for diffview.nvim]], false)
-- Config for: range-highlight.nvim
time([[Config for range-highlight.nvim]], true)
require("plugins/_range_highlight").config()
time([[Config for range-highlight.nvim]], false)
-- Config for: pretty-fold.nvim
time([[Config for pretty-fold.nvim]], true)
require("plugins/_prettyfold").config()
time([[Config for pretty-fold.nvim]], false)
-- Config for: nvim-notify
time([[Config for nvim-notify]], true)
require("plugins/_notifications").config()
time([[Config for nvim-notify]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
require("plugins/_telescope").config()
time([[Config for telescope.nvim]], false)
-- Config for: leap.nvim
time([[Config for leap.nvim]], true)
require("plugins/_leap").config()
time([[Config for leap.nvim]], false)
-- Config for: LuaSnip
time([[Config for LuaSnip]], true)
require("plugins/_luasnip").config()
time([[Config for LuaSnip]], false)
-- Config for: auto-save.nvim
time([[Config for auto-save.nvim]], true)
require("plugins/_autosave").config()
time([[Config for auto-save.nvim]], false)
-- Config for: indent-blankline.nvim
time([[Config for indent-blankline.nvim]], true)
require("plugins/_indent_blankline").config()
time([[Config for indent-blankline.nvim]], false)
-- Config for: onedarkpro.nvim
time([[Config for onedarkpro.nvim]], true)
require("plugins/_onedark").config()
time([[Config for onedarkpro.nvim]], false)

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles(1) end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
