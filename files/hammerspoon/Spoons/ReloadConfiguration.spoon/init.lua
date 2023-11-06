---@class ReloadConfigurationSpoon
local M = {}

---@class ReloadConfigurationSpoon.Config
---@field ignorePaths string[] paths whose changes will not trigger reload
M.config = {}

---update default config
---@param config ReloadConfigurationSpoon.Config
---@return ReloadConfigurationSpoon
function M:setConfig(config)
  if config.ignorePaths then
    config.ignorePaths = hs.fnutils.imap(config.ignorePaths, function(ignorePath)
      return hs.fs.urlFromPath(ignorePath)
    end)
  end

  for key, value in pairs(config) do
    self.config[key] = value
  end

  return self
end

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

---bind hotkey
---@param mapping {reload: table}
---@return ReloadConfigurationSpoon
function M:bindHotkeys(mapping)
  local def = {
    reload = hs.fnutils.partial(self.reload, self),
  }
  hs.spoons.bindHotkeysToSpec(def, mapping)
  return self
end

function M:start()
  self.watcher = hs.pathwatcher.new(hs.configdir, hs.fnutils.partial(self.reload, self))
  self.watcher:start()
end

function M:init()
  self.config = {
    ignorePaths = {},
  }
end

return M
