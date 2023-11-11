local util = require("util")

---@class ReloadConfigurationSpoon
local M = {}

---@class ReloadConfigurationSpoon.Config
M.config = {
  ignorePaths = {
    hs.fs.urlFromPath(hs.spoons.resourcePath("../../annotations")),
    hs.fs.urlFromPath(hs.configdir .. "/stylua.toml"),
  },
}

---reload configuration when the hammerspoon configdir changed
---@param paths? string[] content changed paths
---@param flags? table<string, boolean>[] content change meta
---@return ReloadConfigurationSpoon
function M:reload(paths, flags)
  if not paths or not flags then
    hs.reload()
    return self
  end

  local shouldReload = hs.fnutils.some(paths, function(path)
    local fullPath = hs.fs.urlFromPath(path)
    if not fullPath then
      error("Invalid path found: " .. path)
    end

    local isCreateEvent = hs.fnutils.every(flags, function(flag)
      return flag.itemCreated
    end)
    if isCreateEvent then
      return false
    end

    return hs.fnutils.every(self.config.ignorePaths, function(ignorePath)
      local start = fullPath:find(ignorePath, nil, true)
      return not start
    end)
  end)

  if shouldReload then
    hs.reload()
  end

  return self
end

function M:init()
  self.watcher = hs.pathwatcher.new(hs.configdir, hs.fnutils.partial(self.reload, self))
  self.watcher:start()
  hs.hotkey.bind(util.hyper, "r", nil, hs.fnutils.partial(self.reload, self))
end

return M
