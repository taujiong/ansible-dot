return {
  provider = function()
    icons = require("user.icons")
    local lnum = vim.v.lnum
    if vim.fn.foldlevel(lnum) <= vim.fn.foldlevel(lnum - 1) then return " " end
    return vim.fn.foldclosed(lnum) == -1 and icons.FoldOpened or icons.FoldClosed
  end,
}
