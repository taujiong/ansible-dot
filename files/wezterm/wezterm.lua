local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.color_scheme = "Catppuccin Frappe"
config.colors = {
  background = "black",
}
config.font = wezterm.font("JetBrainsMono Nerd Font Mono", { weight = "Medium" })
config.font_size = 18
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.window_background_opacity = 0.8

return config
