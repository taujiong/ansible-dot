---@class LualsDocSpoon
local M = {}

---@class LualsDocSpoon.Config
---@field annotationPath string dir to write lua type annotations
M.config = {}

---generate lua annotations for installed spoons
---@return LualsDocSpoon
function M:genDocForSpoons()
  local spoonDefs = ""
  for _, spoon in ipairs(hs.spoons.list() or {}) do
    local spoonDef = string.format(
      [[
  ---@type %sSpoon
  %s = {},
]],
      spoon.name,
      spoon.name
    )
    spoonDefs = spoonDefs .. spoonDef
  end
  local fileName = self.config.annotationPath .. "/spoon.lua"
  local fd, err = io.open(fileName, "w+")
  if not fd or err then
    hs.alert.show(string.format("Fail to open file '%s': %s", fileName, err))
    return self
  end
  io.output(fd)
  io.write("spoon = {\n")
  io.write(spoonDefs)
  io.write("}\n")
  io.close(fd)

  return self
end

function M:start()
  hs.fs.mkdir(self.config.annotationPath)
  M:genDocForSpoons()
end

function M:init()
  self.config = {
    annotationPath = hs.spoons.resourcePath("../../annotations"),
  }
end

return M
