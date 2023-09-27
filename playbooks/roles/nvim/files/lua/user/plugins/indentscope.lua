local excluded_file_types = { "help", }
local excluded_buffer_types = { "nofile", }
---@type LazySpec
return {
  "echasnovski/mini.indentscope",
  event = "BufEnter",
  -- for all available options, refer to `:help MiniIndentScope.config`
  opts = {},
  init = function()
    vim.api.nvim_create_autocmd("FileType", {
      desc = "Disable indentscope for certain filetypes",
      pattern = excluded_file_types,
      callback = function(event)
        vim.b[event.buf].miniindentscope_disable = true
      end,
    })
    vim.api.nvim_create_autocmd("BufWinEnter", {
      desc = "Disable indentscope for certain buftypes",
      callback = function(event)
        if vim.tbl_contains(excluded_buffer_types, vim.bo[event.buf].buftype) then
          vim.b[event.buf].miniindentscope_disable = true
        end
      end,
    })
  end,
}
