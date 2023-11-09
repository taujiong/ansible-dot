local wezterm = require("wezterm")
local util = require("util")
local M = {}

M.directionMap = {
  h = "Left",
  j = "Down",
  k = "Up",
  l = "Right",
}

---@return _.wezterm.KeyBinding[]
function M.genNavKeys()
  ---@type _.wezterm.KeyBinding[]
  local keys = {}
  for _, key in ipairs({ "h", "j", "k", "l" }) do
    -- resize or move
    for _, mode in ipairs({ "resize", "move" }) do
      local mods = mode == "resize" and "META" or "CTRL"
      table.insert(keys, {
        key = key,
        mods = mods,
        action = wezterm.action_callback(function(win, pane)
          if util.isVim(pane) then
            win:perform_action({ SendKey = { key = key, mods = mods } }, pane)
          else
            if mode == "resize" then
              win:perform_action({ AdjustPaneSize = { M.directionMap[key], 3 } }, pane)
            else
              win:perform_action({ ActivatePaneDirection = M.directionMap[key] }, pane)
            end
          end
        end),
      })
    end

    -- split
    table.insert(keys, {
      key = key,
      mods = "SUPER",
      action = wezterm.action.SplitPane({ direction = M.directionMap[key] }),
    })
  end
  return keys
end

---update final config
---@param config _.wezterm.ConfigBuilder
function M.config(config)
  local keys = M.genNavKeys()
  config.keys = util.mergeList(config.keys, keys)
end

return M
