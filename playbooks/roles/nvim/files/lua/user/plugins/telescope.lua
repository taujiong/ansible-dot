---@type LazySpec
return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  event = "VeryLazy",
  dependencies = {
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
    { "nvim-lua/plenary.nvim", },
  },
  -- for all available options, refer to `:help telescope.setup`
  opts = function()
    local icons = require("user.icons")
    local actions = require("telescope.actions")
    local trouble = require("trouble.providers.telescope")
    return {
      defaults = {
        prompt_prefix = icons.Selected .. " ",
        selection_caret = icons.Selected .. " ",
        path_display = { "truncate", },
        file_ignore_patterns = { "^.git/", "^node_modules/", },
        sorting_strategy = "ascending",
        layout_config = {
          horizontal = { prompt_position = "top", preview_width = 0.55, },
          vertical = { mirror = false, },
          width = 0.9,
          height = 0.9,
          preview_cutoff = 120,
        },
        mappings = {
          i = {
            ["<c-n>"] = actions.cycle_history_next,
            ["<c-p>"] = actions.cycle_history_prev,
            ["<c-j>"] = actions.move_selection_next,
            ["<c-k>"] = actions.move_selection_previous,
            ["<c-t>"] = trouble.smart_open_with_trouble,
          },
          n = {
            q = actions.close,
            ["<c-t>"] = trouble.smart_open_with_trouble,
          },
        },
      },
      extensions = {
        fzf = {},
      },
    }
  end,
  config = function(_, opts)
    require("telescope").setup(opts)
    require("telescope").load_extension("fzf")
    require("which-key").register({
      f = {
        ["<cr>"] = { require("telescope.builtin").resume, "Resume previous search", },
        ["'"] = { require("telescope.builtin").marks, "Find marks", },
        w = { require("telescope.builtin").live_grep, "Find words", },
        c = { require("telescope.builtin").grep_string, "Find word under cursor", },
        C = { require("telescope.builtin").commands, "Find commands", },
        f = { require("telescope.builtin").find_files, "Find files", },
        F = {
          function()
            require("telescope.builtin").find_files({ hidden = true, no_ignore = true, })
          end,
          "Find all files",
        },
        h = { require("telescope.builtin").help_tags, "Find help", },
        o = { require("telescope.builtin").oldfiles, "Find history", },
        r = { require("telescope.builtin").registers, "Find registers", },
        p = { require("telescope.builtin").builtin, "Find all pickers", },
      },
      g = {
        b = {
          function()
            require("telescope.builtin").git_branches({ use_file_path = true, })
          end,
          "Show git branches",
        },
        c = {
          function()
            require("telescope.builtin").git_commits({ use_file_path = true, })
          end,
          "Show git commits for current repository",
        },
        C = {
          function()
            require("telescope.builtin").git_bcommits({ use_file_path = true, })
          end,
          "Show git commits for current buffer",
        },
      },
    }, { prefix = "<leader>", })
  end,
}
