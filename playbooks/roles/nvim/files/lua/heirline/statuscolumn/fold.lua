return {
  init = function(self)
    self.close_icon = require("user.icons").FoldClosed
    self.open_icon = require("user.icons").FoldOpened
  end,
  on_click = {
    name = "heirline_statuscolumn_fold_click_handle",
    callback = function(self)
      local mouse_pos = vim.fn.getmousepos()
      local char = vim.fn.screenstring(mouse_pos.screenrow, mouse_pos.screencol)
      if char == self.close_icon or char == self.open_icon then
        vim.api.nvim_win_set_cursor(0, { mouse_pos.line, 0, })
        vim.cmd("norm! za")
      end
    end,
  },
  provider = function(self)
    local lnum = vim.v.lnum
    if vim.fn.foldlevel(lnum) <= vim.fn.foldlevel(lnum - 1) then return " " end
    return vim.fn.foldclosed(lnum) == -1 and self.open_icon or self.close_icon
  end,
}
