return {
  condition = function()
    return #vim.api.nvim_list_tabpages() >= 2
  end,

  require("heirline.utils").make_tablist({
    hl = function(self)
      if self.is_active then
        return { bg = "surface2", }
      else
        return { fg = "darken_subtext0", bg = "surface0", }
      end
    end,
    provider = function(self)
      return "%" .. self.tabnr .. "T " .. self.tabnr .. " %T"
    end,
  }),
}
