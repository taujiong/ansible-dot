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
    { "nvim-lua/plenary.nvim" },
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
        path_display = { "truncate" },
        file_ignore_patterns = { "^.git/", "^node_modules/" },
        sorting_strategy = "ascending",
        layout_config = {
          horizontal = { prompt_position = "top", preview_width = 0.55 },
          vertical = { mirror = false },
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
        fzf = {}
      }
    }
  end,
  config = function(_, opts)
    local telescope = require("telescope")
    telescope.setup(opts)
    telescope.load_extension("fzf")
  end,
}
