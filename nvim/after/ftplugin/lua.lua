-- Customize 'mini.nvim'
vim.b.minisurround_config = {
  custom_surroundings = {
    s = {
      input  = { '%[%[().-()%]%]' },
      output = {
        left  = '[[',
        right = ']]'
      }
    },
  },
}

vim.b.miniai_config = {
  custom_textobjects = {
    s = { '%[%[().-()%]%]' },
  },
}

local highlighters = {
  emmylua = { pattern = '^%s*%-%-%-()@%w+()', group = 'Special' }
}

-- Define patterns for all existing highlight groups
local hl_groups = vim.fn.getcompletion("", "highlight")
for _, hl in ipairs(hl_groups) do
  highlighters[hl] = { pattern = "%f[%w]()" .. hl .. "()%f[%W]", group = hl }
end

vim.b.minihipatterns_config = {
  highlighters = highlighters
}
