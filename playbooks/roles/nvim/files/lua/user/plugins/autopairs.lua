---@type LazySpec
return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  opts = {
    check_ts = true,
    ts_config = {
      java = false,
    },
    fast_wrap = false,
  },
  config = function(_, opts)
    require("nvim-autopairs").setup(opts)
    require("cmp").event:on(
      "confirm_done",
      require("nvim-autopairs.completion.cmp").on_confirm_done({ tex = false })
    )
  end,
}
