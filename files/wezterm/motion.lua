local wezterm = require("wezterm")
local M = {}

---check whether the pane is running vim
---@param pane _.wezterm.Pane wezterm pane
function M.isVim(pane)
  return pane:get_user_vars().IS_NVIM == "true"
end

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
          if M.isVim(pane) then
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
  if not config.keys then
    config.keys = keys
  else
    for _, key in ipairs(keys) do
      table.insert(config.keys, key)
    end
  end
end

return M
