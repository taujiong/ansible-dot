---@type LazySpec
return {
  "L3MON4D3/LuaSnip",
  build = vim.fn.has("win32") == 0
      and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build\n'; make install_jsregexp"
      or nil,
  -- for all available options, refer to `:help luasnip-config-options`
  opts = {
    history = true,
    delete_check_events = "TextChanged",
    region_check_events = "CursorMoved",
  },
  config = function(_, opts)
    require("luasnip").setup(opts)
    require("luasnip.loaders.from_vscode").lazy_load({ paths = "./snippets" })
  end,
}
