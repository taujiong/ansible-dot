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
	e = { require("nvim-tree.api").tree.toggle, "Toggle explorer" },
	q = { "<cmd>q<cr>", "Quit" },
	i = { desc = "Toggle cursor word" },
}, { prefix = "<leader>" })

wk.register({
	dm = {
		name = "marks",
		l = { require("marks").delete_line, "Delete marks on current line" },
		f = { require("marks").delete_buf, "Delete marks on current file" },
	},
	m = {
		name = "Marks",
		m = { require("marks").toggle, "Toggle mark" },
		["["] = { require("marks").prev, "Go to previous mark" },
		["]"] = { require("marks").next, "Go to next mark" },
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
		g = { require("neogit").open, "Open git" },
		b = {
			function()
				require("telescope.builtin").git_branches({ use_file_path = true })
			end,
			"Show git branches",
		},
		c = {
			function()
				require("telescope.builtin").git_commits({ use_file_path = true })
			end,
			"Show git commits for current repository",
		},
		C = {
			function()
				require("telescope.builtin").git_bcommits({ use_file_path = true })
			end,
			"Show git commits for current buffer",
		},
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

wk.register({
	f = {
		name = icons.Search .. " Find",
		["<cr>"] = { require("telescope.builtin").resume, "Resume previous search" },
		["'"] = { require("telescope.builtin").marks, "Find marks" },
		w = { require("telescope.builtin").live_grep, "Find words" },
		c = { require("telescope.builtin").grep_string, "Find word under cursor" },
		C = { require("telescope.builtin").commands, "Find commands" },
		f = { require("telescope.builtin").find_files, "Find files" },
		F = {
			function()
				require("telescope.builtin").find_files({ hidden = true, no_ignore = true })
			end,
			"Find all files",
		},
		h = { require("telescope.builtin").help_tags, "Find help" },
		m = { require("telescope.builtin").man_pages, "Find man" },
		n = { "<cmd>Noice telescope<cr>", "Find notifications" },
		o = { require("telescope.builtin").oldfiles, "Find history" },
		r = { require("telescope.builtin").registers, "Find registers" },
		p = { require("telescope.builtin").builtin, "Find all pickers" },
	},
}, { prefix = "<leader>" })
