---@type LazySpec
return {
  "stevearc/conform.nvim",
  event = { "BufEnter" },
  keys = {
    {
      "<leader>lf",
      function()
        require("conform").format({
          timeout_ms = 500,
          lsp_fallback = true,
        })
      end,
      desc = "Format the file (in normal mode) or the range (in visual mode)",
      mode = { "n", "v" },
    },
    { "<leader>pf", "<cmd>ConformInfo<cr>", desc = "Show conform formatters" },
    { "<leader>uf", require("user.utils.customize").toggle_buffer_autoformat, desc = "Toggle autoformatting (buffer)" },
    { "<leader>uF", require("user.utils.customize").toggle_global_autoformat, desc = "Toggle autoformatting (global)" },
  },
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
      jsonc = { "prettierd" },
      yaml = { "prettierd" },
      markdown = { "prettierd" },
      graphql = { "prettierd" },
    },
    format_on_save = function(bufnr)
      -- Disable with a global or buffer-local variable
      if not vim.b[bufnr].autoformat_enabled and not vim.g.autoformat_enabled then
        return
      end
      -- Disable autoformat for files in a certain path
      local bufname = vim.api.nvim_buf_get_name(bufnr)
      if string.match(bufname, "/node_modules/") or string.match(bufname, "/music%-pc/") then
        return
      end
      return {
        lsp_fallback = true,
        timeout_ms = 500,
      }
    end,
  },
  config = function(_, opts)
    require("conform").setup(opts)

    require("user.utils.mason").ensure_mason_package_installed({ "stylua", "prettierd" })
  end,
}
