return {
  init = function(self)
    self.file_type = vim.bo[0].filetype
    self.file_name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t")
  end,

  require("heirline.component").padding(2),

  require("heirline.component").file_icon(),

  -- ft name
  {
    provider = function(self)
      return " " .. self.file_type
    end,
  },
}
