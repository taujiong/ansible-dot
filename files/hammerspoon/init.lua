require("hs.ipc")

for _, spoon in ipairs(hs.spoons.list() or {}) do
  hs.loadSpoon(spoon.name)
end

hs.alert.show("Hammerspoon started")
