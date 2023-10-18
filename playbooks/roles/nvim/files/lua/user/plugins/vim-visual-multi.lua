---@type LazySpec
return {
  "mg979/vim-visual-multi",
  event = "BufEnter",
  config = function()
    vim.cmd([[nmap <C-LeftMouse> <Plug>(VM-Mouse-Cursor)]])
  end,
}
