local function c(module)
  return string.format([[require("plugins/_%s").config()]], module)
end

local function s(module)
  return string.format([[require("plugins/_%s").setup()]], module)
end

return require("packer").startup({
  {
    -- Core
    { "wbthomason/packer.nvim" },
    { "lewis6991/impatient.nvim" },
    { "antoinemadec/FixCursorHold.nvim" },
    { "gpanders/editorconfig.nvim" },
    { "dstein64/vim-startuptime" },
    { "echasnovski/mini.nvim", config = c("mini") },
    { "tpope/vim-sensible", "tpope/vim-repeat" },

    { "Pocco81/auto-save.nvim", config = c("autosave") },
    { "rmagatti/auto-session", config = c("autosession") },
    { "vladdoster/remember.nvim", config = c("remember") },
    { "nmac427/guess-indent.nvim", config = c("guess_indent") },

    -- Core Extensions
    {
      "TimUntersberger/neogit",
      config = c("neogit"),
      requires = {
        { "sindrets/diffview.nvim", config = c("diffview") },
      },
    },

    -- DAP
    -- { "anuvyklack/hydra.nvim", config = c("hydra") },
    -- {
    --   "mfussenegger/nvim-dap",
    --   config = c("dap"),
    --   requires = {
    --     "suketa/nvim-dap-ruby",
    --     "rcarriga/nvim-dap-ui",
    --     "theHamsta/nvim-dap-virtual-text",
    --   },
    -- },

    -- LSP
    { "neovim/nvim-lspconfig" },
    { "ray-x/lsp_signature.nvim" },
    { "stevearc/dressing.nvim" },
    -- {
    --   "NarutoXY/dim.lua",
    --   requires = { "nvim-treesitter/nvim-treesitter", "neovim/nvim-lspconfig" },
    --   config = c("dim"),
    -- },

    -- Theme
    { "olimorris/onedarkpro.nvim", config = c("onedark") },

    -- UI
    { "luukvbaal/stabilize.nvim", config = c("stabilize") },
    { "rcarriga/nvim-notify", config = c("notifications") },
    { "anuvyklack/pretty-fold.nvim", config = c("prettyfold") },
    { "romainl/vim-cool" },
    {
      "yamatsum/nvim-nonicons",
      requires = { "kyazdani42/nvim-web-devicons", config = c("devicons") },
    },
    { "NvChad/nvim-colorizer.lua", config = c("colorizer") },
    {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v2.x",
      config = c("neotree"),
      requires = {
        "nvim-lua/plenary.nvim",
        "kyazdani42/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
      },
    },
    { "akinsho/bufferline.nvim", config = c("bufferline") },
    { "tiagovla/scope.nvim", config = c("scope") },
    { "nvim-lualine/lualine.nvim", config = c("lualine") },
    { "ThePrimeagen/harpoon", requires = { "nvim-lua/plenary.nvim" } },
    {
      "winston0410/range-highlight.nvim",
      config = c("range_highlight"),
      requires = {
        { "winston0410/cmd-parser.nvim" },
      },
    },
    {
      "lewis6991/gitsigns.nvim",
      requires = { "nvim-lua/plenary.nvim" },
      config = c("gitsigns"),
    },
    { "sindrets/winshift.nvim" },
    { "mrjones2014/smart-splits.nvim" },

    -- Telescope
    {
      "nvim-telescope/telescope.nvim",
      config = c("telescope"),
      requires = {
        { "nvim-lua/plenary.nvim" },
      },
    },
    { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
    { "natecraddock/telescope-zf-native.nvim" },
    { "nvim-telescope/telescope-ui-select.nvim" },

    -- Motions
    { "ggandor/leap.nvim", config = c("leap") },
    { "chaoren/vim-wordmotion" },
    { "gbprod/substitute.nvim", config = c("substitute") },
    { "nacro90/numb.nvim", config = c("numb") },

    -- Treesitter
    {
      {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        config = c("treesitter"),
      },
      { "nvim-treesitter/playground" },
      { "nvim-treesitter/nvim-treesitter-textobjects" },
      { "nvim-treesitter/nvim-treesitter-refactor" },
      { "nvim-treesitter/nvim-treesitter-context" },
      { "JoosepAlviste/nvim-ts-context-commentstring" },
      { "windwp/nvim-ts-autotag" },
      { "windwp/nvim-autopairs", config = c("autopairs") },
      { "lukas-reineke/indent-blankline.nvim", config = c("indent_blankline") },
      { "andymass/vim-matchup", setup = s("matchup") },
      -- { "code-biscuits/nvim-biscuits", config = c("codebiscuits") },
      { "RRethy/nvim-treesitter-endwise" },
      { "abecodes/tabout.nvim", config = c("tabout") },
      { "AckslD/nvim-trevJ.lua" },
    },

    -- Completion
    {
      {
        "hrsh7th/nvim-cmp",
        config = c("completion"),
        requires = {
          { "tzachar/cmp-tabnine", run = "./install.sh" },
          { "ray-x/cmp-treesitter" },
          { "saadparwaiz1/cmp_luasnip" },
          { "hrsh7th/cmp-buffer" },
          { "hrsh7th/cmp-path" },
          { "hrsh7th/cmp-nvim-lsp" },
          { "hrsh7th/cmp-cmdline" },
          { "lukas-reineke/cmp-rg" },
          { "hrsh7th/cmp-nvim-lsp-document-symbol" },
          { "onsails/lspkind-nvim" },
          { "tzachar/cmp-fuzzy-path", requires = { "tzachar/fuzzy.nvim" } },
          { "tzachar/cmp-fuzzy-buffer", requires = { "tzachar/fuzzy.nvim" } },
        },
      },
      { "L3MON4D3/LuaSnip", config = c("luasnip") },
    },

    -- Ruby
    {
      "tpope/vim-rails",
      "tpope/vim-projectionist",
      "tpope/vim-rake",
      "tpope/vim-bundler",
      ft = { "ruby", "eruby" },
    },

    -- Quickfix
    {
      { "https://gitlab.com/yorickpeterse/nvim-pqf.git", config = c("pretty_quickfix") },
      { "stevearc/qf_helper.nvim", config = c("quickfix_helper") },
    },

    {
      "nvim-neotest/neotest",
      requires = {
        "olimorris/neotest-rspec",
      },
      config = c("neotest"),
    },
  },
  config = utils.plugin("packer").config,
})
