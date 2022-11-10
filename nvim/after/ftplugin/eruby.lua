-- Donno why I need to wrap this, but it doesn't work if you don't
vim.defer_fn(function() vim.treesitter.start(0, "embedded_template") end, 100)
