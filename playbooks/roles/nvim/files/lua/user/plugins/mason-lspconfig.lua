---@type LazySpec
return {
	"williamboman/mason-lspconfig.nvim",
	dependencies = {
		"williamboman/mason.nvim",
		"neovim/nvim-lspconfig",
	},
	---@type MasonLspconfigSettings
	opts = {
		automatic_installation = true,
		ensure_installed = {
			"lua_ls",
		},
	},
	config = function(_, opts)
		require("mason").setup()
		require("mason-lspconfig").setup(opts)
		require("user.lsp").setup()
	end,
}
