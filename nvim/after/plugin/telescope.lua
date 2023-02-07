local ok, telescope = pcall(require, "telescope")
if not ok then
  return
end

telescope.load_extension("fzf")
telescope.load_extension("zf-native")
telescope.load_extension("ui-select")
telescope.load_extension("harpoon")
telescope.load_extension("live_grep_args")
telescope.load_extension("smart_open")
