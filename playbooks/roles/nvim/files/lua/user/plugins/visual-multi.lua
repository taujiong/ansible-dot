---@type LazySpec
return {
  "mg979/vim-visual-multi",
  event = "BufEnter",
  config = function()
    vim.g.VM_maps = {
      ["Add Cursor Up"] = "<c-s-k>",
      ["Add Cursor Down"] = "<c-s-j>",
    }
  end,
}
