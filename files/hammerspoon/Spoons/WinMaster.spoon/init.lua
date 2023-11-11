---@diagnostic disable: duplicate-set-field
local util = require("util")

---@class WinMasterSpoon
local M = {}

---@class WinMasterSpoon.Config
M.config = {}

function M:bindExit()
  local exitHandle = hs.fnutils.partial(self.hotkeyModal.exit, self.hotkeyModal)
  self.hotkeyModal:bind(util.hyper, "w", "Exit window management mode", exitHandle)
end

function M:bindMove()
  for key, direction in pairs(util.directionMap) do
    local handle = function()
      local focusedWindow = hs.window.focusedWindow()
      local cmd = "focusWindow" .. direction
      focusedWindow[cmd](focusedWindow)
    end
    self.hotkeyModal:bind("ctrl", key, nil, handle)
  end
end

function M:init()
  self.hotkeyModal = hs.hotkey.modal.new(util.hyper, "w", "Enter window management mode")
  M:bindExit()
  M:bindMove()
end

return M
