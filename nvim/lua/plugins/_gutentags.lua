local M = {}

M.setup = function()
  local opts = {
    -- modules = { "ctags", "gtags_cscope" },
    modules = { "ctags" },

    -- config project root markers.
    project_root = { ".root", ".git", "Gemfile" },

    -- generate datebases in cache directory, prevent gtags files polluting project
    cache_dir = vim.fn.expand("~/.cache/tags"),

    generate_on_new = 1,
    generate_on_missing = 1,
    generate_on_write = 1,
    generate_on_empty_buffer = 0,
    ctags_executable = "/usr/local/bin/ctags",
    -- trace = 1, -- Debugging

    ctags_exclude = {
      "*.git",
      "*.svg",
      "*.hg",
      "*/tests/*",
      "build",
      "dist",
      "*sites/*/files/*",
      "bin",
      "node_modules",
      "bower_components",
      "cache",
      "compiled",
      "docs",
      "example",
      "bundle",
      "vendor",
      "Library",
      "*.md",
      "*-lock.json",
      "*.lock",
      "*bundle*.js",
      "*build*.js",
      "*config.js",
      "*__mocks__*",
      "*.jsx",
      "*.js",
      ".*rc*",
      "*.json",
      "*.min.*",
      "*.map",
      "*.bak",
      "*.zip",
      "*.erb",
      "*.html",
      "*.pyc",
      "*.class",
      "*.sln",
      "*.Master",
      "*.csproj",
      "*.tmp",
      "*.csproj.user",
      "*.cache",
      "*.pdb",
      "tags*",
      "cscope.*",
      "*.css",
      "*.less",
      "*.scss",
      "*.exe",
      "*.dll",
      "*.mp3",
      "*.ogg",
      "*.flac",
      "*.swp",
      "*.swo",
      "*.bmp",
      "*.gif",
      "*.ico",
      "*.jpg",
      "*.png",
      "*.rar",
      "*.zip",
      "*.tar",
      "*.tar.gz",
      "*.tar.xz",
      "*.tar.bz2",
      "*.pdf",
      "*.doc",
      "*.docx",
      "*.ppt",
      "*.pptx",
    },
  }

  utils.set_globals(opts, "gutentags_")
end

return M