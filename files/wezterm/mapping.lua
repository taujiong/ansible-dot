local wezterm = require("wezterm")
local util = require("util")
local action = wezterm.action
local M = {}

---@type _.wezterm.KeyBinding[]
M.mappings = {
  -- window management
  { key = "n", mods = "SUPER", action = action.SpawnWindow },
  { key = "=", mods = "SUPER", action = action.IncreaseFontSize },
  { key = "-", mods = "SUPER", action = action.DecreaseFontSize },
  -- tab management
  { key = "t", mods = "SUPER", action = action.SpawnTab("CurrentPaneDomain") },
  { key = "]", mods = "SUPER", action = action.ActivateTabRelative(1) },
  { key = "[", mods = "SUPER", action = action.ActivateTabRelative(-1) },
  { key = ".", mods = "SUPER", action = action.MoveTabRelative(1) },
  { key = ",", mods = "SUPER", action = action.MoveTabRelative(-1) },
  -- pane management
  { key = "w", mods = "SUPER", action = action.CloseCurrentPane({ confirm = true }) },
  { key = "z", mods = "CTRL|SHIFT", action = action.TogglePaneZoomState },
  { key = "d", mods = "SUPER", action = action.ScrollByLine(10) },
  { key = "u", mods = "SUPER", action = action.ScrollByLine(-10) },
  {
    key = "s",
    mods = "SUPER",
    action = wezterm.action_callback(function(win, pane)
      if util.isVim(pane) then
        win:perform_action({ SendKey = { key = "s", mods = "CTRL" } }, pane)
      end
    end),
  },
  -- global
  { key = "c", mods = "SUPER", action = action.CopyTo("Clipboard") },
  { key = "v", mods = "SUPER", action = action.PasteFrom("Clipboard") },
  { key = "f", mods = "SUPER", action = action.Search({ CaseInSensitiveString = "" }) },
  { key = "c", mods = "CTRL|SHIFT", action = action.ActivateCopyMode },
  { key = "f", mods = "CTRL|SHIFT", action = action.QuickSelect },
  { key = "p", mods = "CTRL|SHIFT", action = action.ActivateCommandPalette },
  { key = "l", mods = "CTRL|SHIFT", action = action.ShowDebugOverlay },
}

---update final config
---@param config _.wezterm.ConfigBuilder
function M.config(config)
  config.disable_default_key_bindings = true
  config.keys = util.mergeList(config.keys, M.mappings)
end

return M
