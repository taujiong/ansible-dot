local wezterm = require("wezterm")
local M = {}

---update final config
---@param config _.wezterm.ConfigBuilder
function M.config(config)
  wezterm.on("gui-startup", function(cmd)
    local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
    window:gui_window():maximize()
  end)
end

return M
