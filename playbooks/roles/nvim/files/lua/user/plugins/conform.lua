---@type LazySpec
return {
  "stevearc/conform.nvim",
  event = "VeryLazy",
  -- for all available options, refer to `:help conform-options`
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      javascript = { "prettierd" },
      typescript = { "prettierd" },
      javascriptreact = { "prettierd" },
      typescriptreact = { "prettierd" },
      html = { "prettierd" },
      css = { "prettierd" },
      json = { "prettierd" },
      yaml = { "prettierd" },
      markdown = { "prettierd" },
      graphql = { "prettierd" },
      ["_"] = { "trim_whitespace" },
    },
    format_on_save = function(bufnr)
      -- Disable with a global or buffer-local variable
      if not vim.b[bufnr].autoformat_enabled and not vim.g.autoformat_enabled then
        return
      end
      -- Disable autoformat for files in a certain path
      local bufname = vim.api.nvim_buf_get_name(bufnr)
      if bufname:match("/node_modules/") then
        return
      end
      return {
        lsp_fallback = true,
        timeout_ms = 500,
      }
    end,
  },
  config = function(_, opts)
    local conform = require("conform")
    conform.setup(opts)

    require("user.utils.mason").ensure_mason_package_installed({ "stylua", "prettierd" })

    require("which-key").register({
      lf = {
        function()
          conform.format({
            timeout_ms = 500,
            lsp_fallback = true,
          })
        end,
        "Format the file (in normal mode) or the range (in visual mode)",
      },
      pf = { "<cmd>ConformInfo<cr>", "Show conform formatters" },
      uf = { require("user.utils.ui").toggle_buffer_autoformat, "Toggle autoformatting (buffer)" },
      uF = { require("user.utils.ui").toggle_global_autoformat, "Toggle autoformatting (global)" },
    }, { prefix = "<leader>", mode = { "n", "v" } })
  end,
}
