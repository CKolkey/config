local ok, telescope = pcall(require, "telescope")
if ok then
  telescope.load_extension("zf-native")
  telescope.load_extension("ui-select")
  -- telescope.load_extension("harpoon")
  telescope.load_extension("live_grep_args")
  telescope.load_extension("file_browser")
  telescope.load_extension("fzf")
end
