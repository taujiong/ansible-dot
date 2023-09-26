local wk = require("which-key")
local icons = require("user.icons")

wk.register({
	j = { "v:count == 0 ? 'gj' : 'j'", "Move cursor down", expr = true },
	k = { "v:count == 0 ? 'gk' : 'k'", "Move cursor up", expr = true },
	x = { '"_x', "Cut char without copy" },
	xx = { '"_dd', "Cut line without copy" },
	gx = { require("user.utils").open_with_system, "Open with system app" },
	["\\"] = { "<cmd>split<cr>", "Split horizontally" },
	["|"] = { "<cmd>vsplit<cr>", "Split vertically" },
	["<m-j>"] = { "<cmd>m .+1<cr>==", "Move line down" },
	["<m-k>"] = { "<cmd>m .-2<cr>==", "Move line up" },
	["<c-h>"] = { "<c-w>h", "Go to left window" },
	["<c-j>"] = { "<c-w>j", "Go to lower window" },
	["<c-k>"] = { "<c-w>k", "Go to upper window" },
	["<c-l>"] = { "<c-w>l", "Go to right window" },
	["<c-s>"] = { "<cmd>w<cr>", "Save file" },
	["<c-/>"] = {
		function()
			require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1)
		end,
		"Toggle comment line",
	},
	["<esc>"] = { "<cmd>noh<esc>", "Clear HIGhlight" },
})

wk.register({
	jk = { "<esc>", "Back to normal mode", mode = "i" },
	["<m-j>"] = { "<esc><cmd>m .+1<cr>==gi", "Move line down" },
	["<m-k>"] = { "<esc><cmd>m .-2<cr>==gi", "Move line up" },
	["<c-s>"] = { "<esc><cmd>w<cr>==gi", "Save file" },
}, { mode = "i" })

wk.register({
	["<c-/>"] = {
		"<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
		"Toggle comment for selection",
	},
}, { mode = "v" })

wk.register({
	e = { "<cmd>NvimTreeToggle<cr>", "Toggle explorer" },
	q = { "<cmd>q<cr>", "Quit" },
	i = { desc = "Toggle cursor word" },
}, { prefix = "<leader>" })

wk.register({
	dm = {
		name = "marks",
		l = { "<plug>(Marks-deleteline)<cr>", "Delete marks on current line" },
		f = { "<plug>(Marks-deletebuf)<cr>", "Delete marks on current file" },
	},
	m = {
		name = "Marks",
		m = { "<plug>(Marks-toggle)<cr>", "Toggle mark" },
		["["] = { "<plug>(Marks-prev)<cr>", "Go to previous mark" },
		["]"] = { "<plug>(Marks-next)<cr>", "Go to next mark" },
	},
})

wk.register({
	s = { require("substitute").operator, "Replace with {motion}" },
	ss = { require("substitute").line, "Replace with line" },
	p = { require("substitute").visual, "Replace in visual", { mode = "v" } },
	sx = { require("substitute.exchange").operator, "Exchange with {motion}" },
	sxx = { require("substitute.exchange").line, "Exchange with line" },
	sxc = { require("substitute.exchange").cancel, "Exchange exchange" },
	X = { require("substitute.exchange").visual, "Exchange in visual", { mode = "v" } },
})

wk.register({
	z = {
		R = { require("ufo").openAllFolds, "Open all folds" },
		M = { require("ufo").closeAllFolds, "Close all folds" },
		r = { require("ufo").openFoldsExceptKinds, "Fold less" },
		m = { require("ufo").closeFoldsWith, "Fold more" },
		p = { require("ufo").peekFoldedLinesUnderCursor, "Peek fold" },
	},
})

wk.register({
	["]g"] = { require("gitsigns").next_hunk, "Next git hunk", { prefix = "" } },
	["[g"] = { require("gitsigns").prev_hunk, "Previous git hunk", { prefix = "" } },
	g = {
		name = icons.Git .. " Git",
		l = { require("gitsigns").blame_line, "View git blame" },
		p = { require("gitsigns").preview_hunk, "Preview git hunk" },
		h = { require("gitsigns").reset_hunk, "Reset git hunk" },
		H = { require("gitsigns").reset_buffer, "Reset git buffer" },
		s = { require("gitsigns").stage_hunk, "Stage git hunk" },
		S = { require("gitsigns").state_buffer, "Stage git buffer" },
		u = { require("gitsigns").undo_stage_hunk, "Unstage git buffer" },
		d = { require("gitsigns").diffthis, "View git diff" },
	},
}, { prefix = "<leader>" })

wk.register({
	p = {
		name = icons.Package .. " Packages",
		m = { "<cmd>Mason<cr>", "Show mason packages" },
		s = { "<cmd>Lazy<cr>", "Show lazy plugins" },
		c = { "<cmd>Neoconf<cr>", "Update local/global neoconf" },
		l = { "<cmd>Neoconf lsp<cr>", "Show lsp settings" },
		n = { "<cmd>Neoconf show<cr>", "Show merged neoconf" },
	},
}, { prefix = "<leader>" })

wk.register({
	l = {
		name = icons.ActiveLSP .. " Lsp",
		g = { "<cmd>LspLog<cr>", "Show lsp log" },
		i = { "<cmd>LspInfo<cr>", "Show lsp information" },
		m = { "<cmd>LspRestart<cr>", "Restart lsp" },
	},
}, { prefix = "<leader>" })
