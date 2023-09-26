---@type LazySpec
return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	---@type Options
	opts = {
		icons = {
			group = "",
		},
		operators = {
			s = true,
			gb = true,
		},
	},
	config = function(_, opts)
		require("which-key").setup(opts)
		require("user.mappings")
	end,
}
