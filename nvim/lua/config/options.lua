vim.g.mapleader = "\\"

-- https://www.reddit.com/r/neovim/comments/psl8rq/sexy_folds/
-- vim.o.foldtext    = [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]

vim.opt.breakindent    = true
vim.opt.clipboard      = "unnamedplus"
vim.opt.completeopt    = "menu,menuone,noselect"
vim.opt.cursorline     = true
vim.opt.cursorline     = true
vim.opt.expandtab      = true
vim.opt.foldcolumn     = "1"
vim.opt.foldenable     = true
vim.opt.foldexpr       = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel      = 1
vim.opt.foldlevelstart = 99
vim.opt.foldmethod     = "expr"
vim.opt.foldnestmax    = 4
vim.opt.formatoptions  = "crqnj"
vim.opt.grepprg        = "rg --vimgrep --no-heading --hidden"
vim.opt.ignorecase     = true
vim.opt.inccommand     = "nosplit"
vim.opt.jumpoptions    = "stack"
vim.opt.linebreak      = true
vim.opt.list           = true
vim.opt.mouse          = "a"
vim.opt.number         = true
vim.opt.numberwidth    = 5
vim.opt.pumblend       = 0
vim.opt.relativenumber = true
vim.opt.ruler          = false
vim.opt.scrolloff      = 6
vim.opt.sidescrolloff  = 2
vim.opt.sessionoptions = "buffers,curdir,folds,tabpages,winsize"
vim.opt.shiftwidth     = 2
vim.opt.shortmess      = "atIAcW"
vim.opt.showmode       = false
vim.opt.showtabline    = 0
vim.opt.signcolumn     = "yes:1"
vim.opt.smartcase      = true
vim.opt.smartindent    = true
vim.opt.softtabstop    = 2
vim.opt.splitbelow     = true
vim.opt.splitright     = true
vim.opt.splitkeep      = "screen"
vim.opt.swapfile       = false
vim.opt.tabstop        = 2
vim.opt.termguicolors  = true
vim.opt.textwidth      = 120
vim.opt.colorcolumn    = "120"
vim.opt.timeoutlen     = 300
vim.opt.undofile       = true
vim.opt.undolevels     = 10000
vim.opt.updatetime     = 300
vim.opt.virtualedit    = "block,onemore"
vim.opt.wildmode       = "longest:full,full"
vim.opt.winhighlight   = "Normal:ActiveWindow,NormalNC:InactiveWindow"

vim.opt.listchars = {
  space    = " ",
  tab      = " ",
  trail    = "•",
  extends  = "❯",
  precedes = "❮",
  nbsp     = "␣",
}

vim.opt.fillchars = {
  fold      = " ",
  foldopen  = "",
  foldclose = "",
  foldsep   = " ",
  diff      = "╱",
  eob       = " ",
}

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
