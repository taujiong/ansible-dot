---@type LazySpec
return {
  "stevearc/resession.nvim",
  lazy = false,
  -- for all available options, refer to: `:help resession-options`
  opts = {
    dir = "resession",
  },
  config = function(_, opts)
    local resession = require("resession")
    resession.setup(opts)
    local autocmd = vim.api.nvim_create_autocmd
    local augroup = vim.api.nvim_create_augroup

    autocmd("VimLeavePre", {
      desc = "Save session on close",
      group = augroup("user_resession_auto_save", { clear = true }),
      callback = function()
        resession.save(vim.fn.getcwd(), { notify = false })
      end,
    })

    autocmd("VimEnter", {
      desc = "Restore session on open",
      group = augroup("user_resession_auto_restore", { clear = true }),
      callback = function()
        if vim.fn.argc(-1) == 0 then
          pcall(resession.load, vim.fn.getcwd())
        end
      end,
    })
  end,
}
