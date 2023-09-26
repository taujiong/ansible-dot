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
						["<C-n>"] = actions.cycle_history_next,
						["<C-p>"] = actions.cycle_history_prev,
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
					},
					n = { q = actions.close },
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
