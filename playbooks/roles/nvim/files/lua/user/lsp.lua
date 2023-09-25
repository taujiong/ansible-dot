local M = {}

---@param bufnr number
local on_lsp_attach = function(_, bufnr)
	local opts = { buffer = bufnr }
	vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
	vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
	vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
	vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
	vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
	vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
	vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
	vim.keymap.set("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
	vim.keymap.set({ "n", "x" }, "<leader>lf", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
	vim.keymap.set("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)

	vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", opts)
	vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts)
	vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts)
end

local setup_server_handler = function()
	local lspconfig = require("lspconfig")
	local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()
	require("mason-lspconfig").setup_handlers({
		function(server_name)
			lspconfig[server_name].setup({
				capabilities = cmp_capabilities,
				on_attach = on_lsp_attach,
			})
		end,
		jsonls = function(server_name)
			local schemastore = require("schemastore")
			lspconfig[server_name].setup({
				capabilities = cmp_capabilities,
				settings = {
					json = {
						schemas = schemastore.json.schemas(),
						validate = { enable = true },
					},
				},
			})
		end,
		yamlls = function(server_name)
			local schemastore = require("schemastore")
			lspconfig[server_name].setup({
				capabilities = cmp_capabilities,
				settings = {
					yaml = {
						schemas = schemastore.yaml.schemas(),
					},
				},
			})
		end,
	})
end

function M.setup()
	setup_server_handler()
end

return M
