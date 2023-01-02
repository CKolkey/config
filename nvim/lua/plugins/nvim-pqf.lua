return {
  url = "https://gitlab.com/yorickpeterse/nvim-pqf.git",
  ft = "quickfix",
  config = {
    signs = {
      error = require("config.ui").icons.error,
      warning = require("config.ui").icons.warning,
      info = require("config.ui").icons.info,
      hint = require("config.ui").icons.hint,
    }
  }
}
