---@type LazySpec
return {
	"stevearc/dressing.nvim",
	event = "VeryLazy",
	opts = {
		input = { default_prompt = "➤ " },
		select = { backend = { "nui" } },
	},
}
