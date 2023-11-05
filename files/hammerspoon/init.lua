for _, spoon in ipairs(hs.spoons.list() or {}) do
  hs.loadSpoon(spoon.name)
end

spoon.LualsDoc:start()

spoon.ReloadConfiguration
  :setConfig({
    ignorePaths = { spoon.LualsDoc.config.annotationPath },
  })
  :bindHotkeys({
    reload = { { "shift", "ctrl" }, "R" },
  })
  :start()

hs.alert.show("Hammerspoon started")
