---@type LazySpec
return {
  "lewis6991/gitsigns.nvim",
  event = "BufEnter",
  -- for all available options, refer to `:help gitsigns-config`
  opts = {},
  config = function(_, opts)
    require("gitsigns").setup(opts)
    require("which-key").register({
      ["[g"] = { require("gitsigns").prev_hunk, "Previous git hunk", },
      ["]g"] = { require("gitsigns").next_hunk, "Next git hunk", },
      ["<leader>g"] = {
        l = { require("gitsigns").blame_line, "View git blame", },
        p = { require("gitsigns").preview_hunk, "Preview git hunk", },
        h = { require("gitsigns").reset_hunk, "Reset git hunk", },
        H = { require("gitsigns").reset_buffer, "Reset git buffer", },
        s = { require("gitsigns").stage_hunk, "Stage git hunk", },
        S = { require("gitsigns").state_buffer, "Stage git buffer", },
        u = { require("gitsigns").undo_stage_hunk, "Unstage git buffer", },
        d = { require("gitsigns").diffthis, "View git diff", },
      },
    })
  end,
}
