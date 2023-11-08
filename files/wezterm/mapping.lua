local wezterm = require("wezterm")
local M = {}

---@type _.wezterm.KeyBinding[]
M.mappings = {
  { key = "w", mods = "SUPER", action = wezterm.action.CloseCurrentPane({ confirm = true }) },
  { key = "t", mods = "SUPER", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
  { key = "n", mods = "SUPER", action = wezterm.action.SpawnWindow },
  { key = "c", mods = "SUPER", action = wezterm.action.CopyTo("Clipboard") },
  { key = "v", mods = "SUPER", action = wezterm.action.PasteFrom("Clipboard") },
  { key = "=", mods = "SUPER", action = wezterm.action.IncreaseFontSize },
  { key = "-", mods = "SUPER", action = wezterm.action.DecreaseFontSize },
  { key = "]", mods = "SUPER", action = wezterm.action.ActivateTabRelative(1) },
  { key = "[", mods = "SUPER", action = wezterm.action.ActivateTabRelative(-1) },
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
