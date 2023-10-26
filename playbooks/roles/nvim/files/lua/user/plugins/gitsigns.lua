---@type LazySpec
return {
  "lewis6991/gitsigns.nvim",
  event = { "BufEnter" },
  keys = {
    {
      "[g",
      function()
        require("gitsigns").prev_hunk()
      end,
      desc = "Previous git hunk",
    },
    {
      "]g",
      function()
        require("gitsigns").next_hunk()
      end,
      desc = "Next git hunk",
    },
    {
      "<leader>gl",
      function()
        require("gitsigns").blame_line()
      end,
      desc = "View git blame",
    },
    {
      "<leader>gp",
      function()
        require("gitsigns").preview_hunk()
      end,
      desc = "Preview git hunk",
    },
    {
      "<leader>gh",
      function()
        require("gitsigns").reset_hunk()
      end,
      desc = "Reset git hunk",
    },
    {
      "<leader>gH",
      function()
        require("gitsigns").reset_buffer()
      end,
      desc = "Reset git buffer",
    },
    {
      "<leader>gs",
      function()
        require("gitsigns").stage_hunk()
      end,
      desc = "Stage git hunk",
    },
    {
      "<leader>gS",
      function()
        require("gitsigns").state_buffer()
      end,
      desc = "Stage git buffer",
    },
    {
      "<leader>gu",
      function()
        require("gitsigns").undo_stage_hunk()
      end,
      desc = "Unstage git buffer",
    },
    {
      "<leader>gd",
      function()
        require("gitsigns").diffthis()
      end,
      desc = "View git diff",
    },
  },
  -- for all available options, refer to `:help gitsigns-config`
  opts = {
    max_file_length = vim.g.max_file.lines,
    preview_config = {
      border = "rounded",
    },
  },
}
