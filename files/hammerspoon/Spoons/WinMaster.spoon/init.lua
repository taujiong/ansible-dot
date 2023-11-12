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

function M:bindFocus()
  for key, direction in pairs(util.directionMap) do
    local handle = function()
      local focusedWindow = hs.window.focusedWindow()
      local cmd = "focusWindow" .. direction
      focusedWindow[cmd](focusedWindow)
    end
    self.hotkeyModal:bind("ctrl", key, nil, handle)
  end
end

function M:bindMove()
  for key, _ in pairs(util.directionMap) do
    local handle = function(step)
      local focusedWindow = hs.window.focusedWindow()
      local frame = focusedWindow:frame()
      if key == "h" then
        frame.x = frame.x - step
      elseif key == "j" then
        frame.y = frame.y - step
      elseif key == "k" then
        frame.y = frame.y + step
      elseif key == "l" then
        frame.x = frame.x + step
      end
      focusedWindow:setFrame(frame)
    end
    local fastMove = hs.fnutils.partial(handle, 50)
    local slowMove = hs.fnutils.partial(handle, 10)
    self.hotkeyModal:bind({ "shift" }, key, nil, fastMove, nil, fastMove)
    self.hotkeyModal:bind({}, key, nil, slowMove, nil, slowMove)
  end
end

function M:bindResize()
  for key, _ in pairs(util.directionMap) do
    local handle = function(step)
      local focusedWindow = hs.window.focusedWindow()
      local frame = focusedWindow:frame()
      if key == "h" then
        frame.w = frame.w - step
      elseif key == "j" then
        frame.h = frame.h - step
      elseif key == "k" then
        frame.h = frame.h + step
      elseif key == "l" then
        frame.w = frame.w + step
      end
      focusedWindow:setFrameInScreenBounds(frame)
    end
    local fastResize = hs.fnutils.partial(handle, 50)
    local slowResize = hs.fnutils.partial(handle, 10)
    self.hotkeyModal:bind({ "alt", "shift" }, key, nil, fastResize, nil, fastResize)
    self.hotkeyModal:bind({ "alt" }, key, nil, slowResize, nil, slowResize)
  end
end

function M:init()
  self.hotkeyModal = hs.hotkey.modal.new(util.hyper, "w", "Enter window management mode")
  M:bindExit()
  M:bindFocus()
  M:bindMove()
  M:bindResize()
end

return M
