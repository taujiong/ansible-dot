return {
	"kyazdani42/nvim-tree.lua",
	cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFocus", "NvimTreeFindFileToggle" },
	-- for all available options, refer to `:help nvim-tree-opts`
	opts = {
		auto_reload_on_write = false,
		disable_netrw = true,
		sync_root_with_cwd = true,
		view = {
			centralize_selection = true,
		},
		renderer = {
			full_name = true,
			indent_width = 1,
			special_files = {},
			highlight_git = true,
			highlight_diagnostics = true,
			root_folder_label = ":t",
		},
		update_focused_file = {
			enable = true,
		},
		diagnostics = {
			enable = true,
			debounce_delay = 50,
			severity = {
				min = vim.diagnostic.severity.WARN,
				max = vim.diagnostic.severity.ERROR,
			},
		},
		filters = {
			custom = { "^\\.git$" },
		},
		actions = {
			open_file = {
				quit_on_open = true,
				resize_window = false,
				window_picker = {
					enable = true,
					picker = "default",
					chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
				},
			},
			remove_file = {
				close_window = false,
			},
		},
	},
}
