---@type LazySpec
return {
  "echasnovski/mini.indentscope",
  event = "VeryLazy",
  opts = {},
  init = function()
    vim.api.nvim_create_autocmd("FileType", {
      desc = "Disable indentscope for certain filetypes",
      pattern = { "help" },
      callback = function(event)
        vim.b[event.buf].miniindentscope_disable = true
      end,
    })
    vim.api.nvim_create_autocmd("BufWinEnter", {
      desc = "Disable indentscope for certain buftypes",
      callback = function(event)
        if vim.tbl_contains({ "nofile" }, vim.bo[event.buf].buftype) then
          vim.b[event.buf].miniindentscope_disable = true
        end
      end,
    })
  end,
}
