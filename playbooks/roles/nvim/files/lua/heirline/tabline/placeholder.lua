return {
  condition = function(self)
    self.winid = vim.api.nvim_tabpage_list_wins(0)[1]
    return require("heirline.conditions").buffer_matches({
      filetype = {
        "NvimTree",
      },
    }, vim.api.nvim_win_get_buf(self.winid))
  end,
  provider = function(self)
    return string.rep(" ", vim.api.nvim_win_get_width(self.winid) + 1)
  end,
}
