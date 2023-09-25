---@type LazySpec
return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = "VeryLazy",
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
		"nvim-treesitter/nvim-treesitter-textobjects",
		"windwp/nvim-ts-autotag",
	},
	---@type TSConfig
	---@diagnostic disable-next-line: missing-fields
	opts = {
		ensure_installed = { "bash", "markdown", "markdown_inline", "regex", "vim" },
		auto_install = true,
		autotag = { enable = true },
		highlight = { enable = true },
		indent = { enable = true },
		context_commentstring = {
			enable = true,
			enable_autocmd = false,
		},
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<C-=>",
				node_incremental = "<C-=>",
				scope_incremental = "<nop>",
				node_decremental = "<C-->",
			},
		},
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end,
}
