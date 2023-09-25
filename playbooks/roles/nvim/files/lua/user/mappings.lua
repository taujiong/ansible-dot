local wk = require("which-key")
local icons = require("user.icons")

wk.register({
	e = { "<cmd>NvimTreeToggle<cr>", "Toggle explorer" },
}, { prefix = "<leader>" })

wk.register({
	p = {
		name = icons.Package .. " Packages",
		m = { "<cmd>Mason<cr>", "Mason status" },
		s = { "<cmd>Lazy<cr>", "Plugins status" },
	},
}, { prefix = "<leader>" })

wk.register({
	l = {
		name = icons.ActiveLSP .. " Lsp",
		g = { "<cmd>LspLog<cr>", "Show lsp log" },
		i = { "<cmd>LspInfo<cr>", "Lsp information" },
		m = { "<cmd>LspRestart<cr>", "Lsp restart" },
	},
}, { prefix = "<leader>" })
