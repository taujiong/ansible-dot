local wezterm = require("wezterm")
local M = {}

---@type _.wezterm.KeyBinding[]
M.mappings = {
  { key = "w", mods = "SUPER", action = wezterm.action.CloseCurrentPane({ confirm = true }) },
}

---update final config
---@param config _.wezterm.ConfigBuilder
function M.config(config)
  config.disable_default_key_bindings = true
  if not config.keys then
    config.keys = M.mappings
  else
    for _, keybinding in pairs(M.mappings) do
      table.insert(config.keys, keybinding)
    end
  end
end

return M
