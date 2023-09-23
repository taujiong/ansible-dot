local wk = require("which-key")
local icons = require("user.icons")

wk.register({
	e = { "<cmd>NvimTreeToggle<cr>", "Toggle explorer" },
}, { prefix = "<leader>" })

wk.register({
	p = {
		name = icons.Package .. " Packages",
		s = { "<cmd>Lazy<cr>", "Plugins status" },
	},
}, { prefix = "<leader>" })
