local wezterm = require("wezterm")
local config = wezterm.config_builder()

require("ui").config(config)
require("mapping").config(config)
require("motion").config(config)

return config
