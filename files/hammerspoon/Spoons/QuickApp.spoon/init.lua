local util = require("util")

---@class QuickAppSpoon
local M = {}

---@class QuickAppSpoon.config
M.config = {
  mappings = {
    ["com.github.wez.wezterm"] = ".",
    ["com.microsoft.edgemac"] = "b",
    ["com.microsoft.VSCode"] = "c",
  },
}

function M:init()
  for appName, key in pairs(self.config.mappings) do
    local handle = function()
      local app = hs.application.find(appName)
      if not app or not app:focusedWindow() then
        hs.application.open(appName)
      elseif app:isFrontmost() then
        app:hide()
      else
        ---@type hs.window
        local appWindow = app:focusedWindow()
        local curSpace = hs.spaces.activeSpaceOnScreen()
        hs.spaces.moveWindowToSpace(appWindow, curSpace)
        local curScreen = hs.screen.mainScreen()
        appWindow:moveToScreen(curScreen)
        app:activate()
      end
    end
    hs.hotkey.bind(util.hyper, key, nil, handle)
  end
end

return M
