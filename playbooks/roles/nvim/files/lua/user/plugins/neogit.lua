---@type LazySpec
return {
  "NeogitOrg/neogit",
  event = "VeryLazy",
  -- for all available options, refer to `:help neogit`
  ---@type NeogitConfig
  opts = {
    disable_insert_on_commit = "auto",
    status = {
      recent_commit_count = 20,
    },
    telescope_sorter = function()
      return require("telescope").extensions.fzf.native_fzf_sorter()
    end,
    ---@diagnostic disable-next-line: missing-fields
    signs = {
      item = { require("user.icons").Heirline.FoldClosed, require("user.icons").Heirline.FoldOpened },
      section = { require("user.icons").Heirline.FoldClosed, require("user.icons").Heirline.FoldOpened },
    },
  },
  config = function(_, opts)
    require("neogit").setup(opts)
    require("which-key").register({
      ["<leader>gg"] = { require("neogit").open, "Open neogit" },
    })
  end,
  init = function()
    vim.api.nvim_create_autocmd("FileType", {
      desc = "Disable statuscolumn for NeogitStatus",
      pattern = { "NeogitStatus" },
      callback = function()
        vim.wo.statuscolumn = ""
      end,
    })
  end,
}
