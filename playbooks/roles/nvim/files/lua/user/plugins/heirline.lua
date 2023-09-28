---@type LazySpec
return {
  "rebelot/heirline.nvim",
  priority = 100,
  -- for all available options, refer to: https://github.com/rebelot/heirline.nvim/blob/master/cookbook.md
  opts = {
    opts = {
      colors = function()
        local palette = require("catppuccin.palettes").get_palette()
        local darken = require("catppuccin.utils.colors").darken
        local colors = {}
        for name, color in pairs(palette) do
          colors[name] = color
          colors["darken_" .. name] = darken(color, 0.7)
        end

        return colors
      end,
    },
    statusline = {
      require("user.components.mode"),
      require("user.components.git"),
      require("user.components.ft"),
      require("user.components.diagnostic"),
      { provider = "%=", },
      require("user.components.cmd"),
      { provider = "%=", },
      require("user.components.lsp"),
      require("user.components.ruler"),
    },
  },
}
