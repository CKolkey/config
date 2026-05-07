return {
  "https://codeberg.org/andyg/leap.nvim",
  lazy = false,
  config = function()
    -- Highly recommended: define a preview filter to reduce visual noise
    -- and the blinking effect after the first keypress.
    -- For example, define word boundaries as the common case, that is, skip
    -- preview for matches starting with whitespace or an alphabetic
    -- mid-word character: foobar[baaz] = quux
    --                     *    ***  ** * *  *
    require('leap').opts.preview = function(ch0, ch1, ch2)
      return not (
        ch1:match('%s')
        or (ch0:match('%a') and ch1:match('%a') and ch2:match('%a'))
      )
    end

    -- Enable the traversal keys to repeat the previous search without
    -- explicitly invoking Leap (`<cr><cr>...` instead of `s<cr><cr>...`):
    do
      local clever = require('leap.user').with_traversal_keys
      -- For relative directions, set the `backward` flags according to:
      -- local prev_backward = require('leap').state['repeat'].backward
      vim.keymap.set({ 'n', 'x', 'o' }, '<cr>', function()
        require('leap').leap {
          ['repeat'] = true, opts = clever('<cr>', '<bs>'),
        }
      end)
      vim.keymap.set({ 'n', 'x', 'o' }, '<bs>', function()
        require('leap').leap {
          ['repeat'] = true, opts = clever('<bs>', '<cr>'), backward = true,
        }
      end)
    end

    -- Clever F
    do
      local function ft(key_specific_args)
        require('leap').leap(
          vim.tbl_deep_extend('keep', key_specific_args, {
            inputlen = 1,
            inclusive = true,
            opts = {
              -- Force autojump.
              labels = '',
              -- Match the modes where you don't need labels (`:h mode()`).
              safe_labels = vim.fn.mode(1):match('o') and '' or nil,
            },

          })
        )
      end

      -- A helper function making it easier to set "clever-f" behavior
      -- (using f/F or t/T instead of ;/, - see the plugin clever-f.vim).
      local clever = require('leap.user').with_traversal_keys
      local clever_f, clever_t = clever('f', 'F'), clever('t', 'T')

      vim.keymap.set({ 'n', 'x', 'o' }, 'f', function()
        ft { opts = clever_f }
      end)
      vim.keymap.set({ 'n', 'x', 'o' }, 'F', function()
        ft { backward = true, opts = clever_f }
      end)
      vim.keymap.set({ 'n', 'x', 'o' }, 't', function()
        ft { offset = -1, opts = clever_t }
      end)
      vim.keymap.set({ 'n', 'x', 'o' }, 'T', function()
        ft { backward = true, offset = 1, opts = clever_t }
      end)
    end
  end
}
