vim.g.mapleader = "\\"

-- stylua: ignore
local opts       = {
  breakindent    = true,
  clipboard      = "unnamedplus",
  colorcolumn    = "120",
  completeopt    = "menu,menuone,noselect",
  cursorline     = true,
  dictionary     = "/usr/share/dict/words",
  expandtab      = true,
  fillchars      = Icons.fillchars,
  -- foldexpr       = "v:lua.vim.treesitter.foldexpr()",
  foldlevel      = 99,
  foldlevelstart = 99,
  foldnestmax    = 10,
  -- foldtext       = "v:lua.vim.treesitter.foldtext()",
  formatoptions  = "crqnj",
  grepprg        = "rg --vimgrep --no-heading --hidden",
  ignorecase     = true,
  inccommand     = "nosplit",
  jumpoptions    = { "stack", "view" },
  laststatus     = 3,
  linebreak      = true,
  list           = true,
  listchars      = Icons.listchars,
  mouse          = "a",
  pumblend       = 0,
  ruler          = false,
  scrolloff      = 6,
  sessionoptions = "buffers,tabpages,winsize",
  shiftwidth     = 2,
  shortmess      = "atIAcW",
  showmode       = false,
  showtabline    = 0,
  sidescrolloff  = 2,
  signcolumn     = "yes:1",
  smartcase      = true,
  smartindent    = true,
  smoothscroll   = true,
  softtabstop    = 2,
  spell          = true,
  spelllang      = "en_us",
  splitbelow     = true,
  splitkeep      = "screen",
  splitright     = true,
  swapfile       = false,
  tabstop        = 2,
  termguicolors  = true,
  textwidth      = 120,
  timeoutlen     = 300,
  undofile       = true,
  undolevels     = 10000,
  updatetime     = 300,
  virtualedit    = "block,onemore",
  wildmode       = "longest:full,full",
}

for key, value in pairs(opts) do
  vim.opt[key] = value
end
-- Disable Builtins
local builtins = {
  "gzip",
  "2html_plugin",
  "getscript",
  "getscriptPlugin",
  "logiPat",
  "matchit",
  "matchparen",
  "netrw",
  "netrwFileHandlers",
  "netrwPlugin",
  "netrwSettings",
  "rrhelper",
  "tar",
  "tarPlugin",
  "vimball",
  "vimballPlugin",
  "zip",
  "zipPlugin",
}

for _, plugin in ipairs(builtins) do
  vim.g["loaded_" .. plugin] = 1
end

-- Filetype Specific
vim.g.no_ruby_maps = true
