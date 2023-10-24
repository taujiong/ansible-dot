---@type LazySpec[]
return {
  {
    "echasnovski/mini.bufremove",
    -- for all available options, refer to `:help mini.bufremove.config`
    opts = {
      silent = true,
    },
  },
  {
    "kylechui/nvim-surround",
    event = { "BufEnter" },
    -- for all available options, refer to `:help nvim-surround.configuration`
    opts = {},
  },
  {
    "NvChad/nvim-colorizer.lua",
    event = { "BufEnter" },
    -- for all available options, refer to `:help colorizer.user_default_options`
    opts = {},
  },
  { "nvim-tree/nvim-web-devicons" },
  { "nvim-lua/plenary.nvim" },
  { "MunifTanjim/nui.nvim" },
  { "b0o/SchemaStore.nvim" },
}
