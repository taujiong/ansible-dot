return {
  init = function(self)
    self.file_type = vim.bo[0].filetype
    self.file_name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t")
  end,

  -- padding
  {
    provider = "  ",
  },

  -- icon
  {
    hl = function(self)
      local devicons = require("nvim-web-devicons")
      local _, color = devicons.get_icon_color(self.file_name)
      if not color then
        _, color = devicons.get_icon_color_by_filetype(self.file_type, { default = true, })
      end
      return { fg = color, }
    end,
    provider = function(self)
      local devicons = require("nvim-web-devicons")
      local ft_icon, _ = devicons.get_icon(self.file_name)
      if not ft_icon then
        ft_icon, _ = devicons.get_icon_by_filetype(self.file_type, { default = true, })
      end

      return ft_icon
    end,
  },

  -- ft name
  {
    provider = function(self)
      return " " .. self.file_type
    end,
  },
}
