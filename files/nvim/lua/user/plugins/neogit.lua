---@type LazySpec
return {
  "NeogitOrg/neogit",
  keys = {
    {
      "<leader>gg",
      function()
        require("neogit").open()
      end,
      desc = "Open neogit",
    },
  },
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
