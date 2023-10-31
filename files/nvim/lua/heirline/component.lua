return {
  -- there should be the following fields in the parent context `self`:
  --   * file_name
  --   * file_type
  --   * is_active(optional)
  file_icon = function()
    return {
      hl = function(self)
        if not self.is_active then
          return {}
        end
        local devicons = require("nvim-web-devicons")
        local _, color = devicons.get_icon_color(self.file_name)
        if not color then
          _, color = devicons.get_icon_color_by_filetype(self.file_type, { default = true })
        end
        return { fg = color }
      end,
      provider = function(self)
        local devicons = require("nvim-web-devicons")
        local ft_icon, _ = devicons.get_icon(self.file_name)
        if not ft_icon then
          ft_icon, _ = devicons.get_icon_by_filetype(self.file_type, { default = true })
        end

        return ft_icon
      end,
    }
  end,
  -- flexible component that will occupy as enough space
  fill = function()
    return { provider = "%=" }
  end,
  -- padding spaces
  padding = function(size)
    return { provider = string.rep(" ", size or 2) }
  end,
}
