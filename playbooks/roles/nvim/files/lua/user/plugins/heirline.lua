---@type LazySpec
return {
  "rebelot/heirline.nvim",
  event = { "VimEnter" },
  -- for all available options, refer to: https://github.com/rebelot/heirline.nvim/blob/master/cookbook.md
  opts = function()
    return {
      opts = {
        disable_winbar_cb = function(args)
          return not vim.api.nvim_buf_is_valid(args.buf)
            or require("heirline.conditions").buffer_matches({
              buftype = { "help", "nofile", "quickfix", "terminal", "prompt" },
              filetype = { "NvimTree", "NeogitStatus", "NeogitCommitMessage" },
            }, args.buf)
        end,
        colors = function()
          local palette = require("catppuccin.palettes").get_palette()
          if not palette then
            return {}
          end
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
        require("heirline.statusline.mode"),
        require("heirline.statusline.ft"),
        require("heirline.statusline.git"),
        require("heirline.statusline.diagnostic"),
        require("heirline.component").fill(),
        require("heirline.statusline.cmd"),
        require("heirline.component").fill(),
        require("heirline.statusline.lsp"),
        require("heirline.statusline.ruler"),
      },
      tabline = {
        require("heirline.tabline.placeholder"),
        require("heirline.utils").make_buflist(
          require("heirline.tabline.buffer"),
          { provider = "  " .. require("user.icons").Heirline.ArrowLeft },
          { provider = "  " .. require("user.icons").Heirline.ArrowRight }
        ),
        require("heirline.component").fill(),
        require("heirline.tabline.tab"),
      },
      statuscolumn = {
        require("heirline.statuscolumn.fold"),
        require("heirline.statuscolumn.number"),
        require("heirline.component").padding(1),
        require("heirline.statuscolumn.sign"),
      },
      winbar = {
        require("heirline.winbar.path"),
        require("heirline.winbar.breadcrumb"),
      },
    }
  end,
}
