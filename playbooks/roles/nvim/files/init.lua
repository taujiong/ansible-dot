-- enable experimental Lua module loader for better performance
-- require nvim version >= 0.9.1
-- for more information, refer to:
--   - https://neovim.io/doc/user/lua.html#vim.loader
--   - `:help lua-loader`
vim.loader.enable()

require("user.utils").pre_lazy()

-- ensure lazy.nvim is ready
local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- TODO: remove `vim.loop` when neovim drop it
if not (vim.uv or vim.loop).fs_stat(lazy_path) then
  print("no lazy.nvim found, installing...")
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    "https://github.com/folke/lazy.nvim.git",
    lazy_path,
  })
  print("lazy.nvim installed, loading plugins...")
end
vim.opt.rtp:prepend(lazy_path)

-- ask lazy.nvim to bootstrap my plugins
require("lazy").setup({
  spec = { import = "user.plugins", },
  lockfile = vim.fn.stdpath("data") .. "/lazy-lock.json",
  install = {
    colorscheme = { "catppuccin", },
  },
  change_detection = {
    notify = false,
  },
  performance = {
    rtp = {
      disabled_plugins = { "tohtml", "gzip", "zipPlugin", "netrwPlugin", "tarPlugin", },
    },
  },
})

require("user.utils").post_lazy()
