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
  {
    "mg979/vim-visual-multi",
    event = { "BufEnter" },
    config = function()
      vim.cmd([[nmap <C-LeftMouse> <Plug>(VM-Mouse-Cursor)]])
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = { "InsertEnter" },
    -- for all available options, refer to `:help nvim-autopairs-default-values`
    opts = {
      check_ts = true,
      ts_config = {
        java = false,
      },
      fast_wrap = false,
    },
    config = function(_, opts)
      require("nvim-autopairs").setup(opts)
      require("cmp").event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done({ tex = false }))
    end,
  },
  {
    "nguyenvukhang/nvim-toggler",
    keys = {
      {
        "<leader>i",
        function()
          require("nvim-toggler").toggle()
        end,
        desc = "Toggle cursor word",
      },
    },
    -- for all available options, refer to `:help nvim-toggler-nvim-toggler`
    opts = {
      inverses = {
        ["True"] = "False",
        ["good"] = "bad",
      },
    },
  },
  {
    "stevearc/dressing.nvim",
    lazy = false,
    -- for all available options, refer to `:help dressing-configuration`
    opts = {
      input = {
        default_prompt = require("user.icons").UI.Selected .. " ",
      },
      select = {
        backend = { "telescope", "nui", "builtin" },
      },
    },
  },
  {
    "folke/trouble.nvim",
    -- for all available options, refer to: `:help trouble.nvim-trouble-configuration`
    ---@type TroubleOptions
    opts = {
      use_diagnostic_signs = true,
    },
  },
  { "nvim-tree/nvim-web-devicons" },
  { "nvim-lua/plenary.nvim" },
  { "MunifTanjim/nui.nvim" },
  { "b0o/SchemaStore.nvim" },
}
