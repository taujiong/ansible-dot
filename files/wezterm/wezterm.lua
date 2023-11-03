local term = require("wezterm")
local config = {}

config.color_scheme = "Catppuccin Frappe"
config.colors = {
  background = "black",
}
config.font = term.font("JetBrainsMono Nerd Font Mono", { weight = "Medium" })
config.font_size = 18
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.window_background_opacity = 0.8

return config
