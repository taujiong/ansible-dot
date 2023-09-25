---@type LazySpec
return {
	"catppuccin/nvim",
	name = "catppuccin",
	---@type CatppuccinOptions
	opts = {
		transparent_background = true,
		flavour = "frappe",
		term_colors = true,
		integrations = {
			nvimtree = true,
			markdown = true,
		},
	},
}
