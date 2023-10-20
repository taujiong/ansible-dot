return {
  require("heirline.component").padding(3),

  {
    provider = function()
      local relative_path = vim.fn.expand("%:~:.")
      local sep = string.format(" %s ", require("user.icons").Heirline.sep)
      return relative_path:gsub("/", sep)
    end,
  },
}
