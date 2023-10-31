---@type LazySpec
return {
  "folke/noice.nvim",
  event = { "VeryLazy" },
  keys = {
    { "<leader>fn", "<cmd>Noice telescope<cr>", desc = "Find notifications" },
  },
  -- for all available options, refer to `:help noice.nvim-noice-(nice,-noise,-notice)-configuration`
  ---@type NoiceConfig
  opts = {
    lsp = {
      message = {
        enabled = false,
      },
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
      lsp_doc_border = true,
      cmdline_output_to_split = true,
    },
    views = {
      split = {
        enter = true,
      },
    },
    routes = {
      {
        filter = {
          event = "msg_show",
          kind = "",
          find = "written",
        },
        opts = {
          skip = true,
        },
      },
    },
  },
  config = function(_, opts)
    require("noice").setup(opts)
  end,
  init = function()
    require("which-key").register({
      ["<c-d>"] = {
        function()
          if not require("noice.lsp").scroll(4) then
            return "<c-d>"
          end
        end,
        "Scroll down",
      },
      ["<c-u>"] = {
        function()
          if not require("noice.lsp").scroll(-4) then
            return "<c-u>"
          end
        end,
        "Scroll up",
      },
    }, { mode = { "n", "i", "s" }, expr = true })
  end,
}
