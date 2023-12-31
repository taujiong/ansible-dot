-- enable experimental Lua module loader for better performance
-- require nvim version >= 0.9.1
-- for more information, refer to:
--   - https://neovim.io/doc/user/lua.html#vim.loader
--   - `:help lua-loader`
vim.loader.enable()

require("user.utils.lazy").prepare()

-- ensure lazy.nvim is ready
local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazy_path) then
  print("no lazy.nvim found, installing...")
  vim
    .system({
      "git",
      "clone",
      "--filter=blob:none",
      "--branch=stable",
      "https://github.com/folke/lazy.nvim.git",
      lazy_path,
    })
    :wait()
  print("lazy.nvim installed, loading plugins...")
end
vim.opt.rtp:prepend(lazy_path)

-- ask lazy.nvim to bootstrap my plugins
require("lazy").setup({
  spec = { import = "user.plugins" },
  defaults = {
    lazy = true,
  },
  lockfile = vim.fn.stdpath("data") .. "/lazy-lock.json",
  install = {
    colorscheme = { "catppuccin" },
  },
  ui = {
    border = "rounded",
  },
  checker = {
    enabled = true,
    frequency = 7 * 24 * 60 * 60,
  },
  change_detection = {
    notify = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "tohtml",
        "gzip",
        "zipPlugin",
        "netrwPlugin",
        "tarPlugin",
        "tutor",
      },
    },
  },
})

require("user.utils.lazy").polish()
