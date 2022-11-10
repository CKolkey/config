local M = {}

local opt = setmetatable({}, {
  __newindex = function(_, key, value)
    vim.o[key] = value
    vim.bo[key] = value
  end,
})

function M.load()
  vim.g.mapleader = "\\"

  -- Disable Builtins
  local builtins = {
    gzip = 1,
    zip = 1,
    zipPlugin = 1,
    tar = 1,
    tarPlugin = 1,
    getscript = 1,
    getscriptPlugin = 1,
    vimball = 1,
    vimballPlugin = 1,
    ["2html_plugin"] = 1,
    matchit = 1,
    matchparen = 1,
    logiPat = 1,
    rrhelper = 1,
    netrw = 1,
    netrwPlugin = 1,
    netrwSettings = 1,
  }

  utils.set_globals(builtins, "loaded_")

  -- vim.cmd([[filetype plugin indent on]])

  -- Global and Buffer
  opt.expandtab = true
  opt.grepprg = "rg --vimgrep --no-heading --hidden"
  opt.shiftwidth = 2
  opt.softtabstop = 2
  opt.swapfile = false
  opt.tabstop = 2
  opt.textwidth = 120
  opt.undofile = true
  opt.undolevels = 10000

  -- Global
  vim.o.jumpoptions = "stack"
  vim.o.smartcase = true
  vim.o.splitbelow = true
  vim.o.splitright = true
  vim.o.clipboard = "unnamedplus"
  vim.o.completeopt = "menu,menuone,noselect"
  vim.o.cursorline = true
  vim.o.foldlevelstart = 99
  vim.o.showmode = false
  vim.o.numberwidth = 5
  vim.o.ignorecase = true
  vim.o.mouse = "a"
  vim.o.pumblend = 0
  vim.o.ruler = false
  vim.o.scrolloff = 6
  vim.o.showtabline = 0
  vim.o.termguicolors = true
  vim.o.timeoutlen = 500
  vim.o.updatetime = 300
  vim.o.virtualedit = "block,onemore"
  vim.o.wildmode = "longest,full"
  vim.o.shortmess = "atIAcW"
  vim.o.formatoptions = "crqnj"
  vim.o.smartindent = true
  vim.o.sessionoptions = "buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"
  vim.o.list = true
  vim.opt.listchars = {
    space = " ",
    tab = " ",
    trail = "•",
    extends = "❯",
    precedes = "❮",
    nbsp = "␣",
  }

  vim.opt.fillchars = {
    fold = " ",
    foldopen = "",
    foldclose = "",
    foldsep = " ",
    diff = "╱",
    eob = " ",
  }

  -- https://www.reddit.com/r/neovim/comments/psl8rq/sexy_folds/
  vim.o.foldnestmax = 4
  vim.o.foldlevel = 1
  vim.o.foldcolumn = "1"
  vim.o.foldexpr = "nvim_treesitter#foldexpr()"
  vim.o.foldmethod = "expr"
  -- vim.o.foldtext    = [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]

  -- Window Scoped
  vim.wo.foldenable = true
  vim.wo.signcolumn = "yes:1"
  vim.wo.breakindent = true
  vim.wo.linebreak = true
  vim.wo.number = true
  vim.wo.relativenumber = true
  vim.wo.cursorline = true
  -- vim.wo.cursorcolumn = true
  vim.wo.winhighlight = "Normal:ActiveWindow,NormalNC:InactiveWindow"
end

return M
