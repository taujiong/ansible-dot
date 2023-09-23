return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	---@type Options
	opts = {
		plugins = {
			marks = false,
			registers = false,
		},
	},
	config = function(_, opts)
		require("which-key").setup(opts)
		require("user.mappings")
	end,
}
