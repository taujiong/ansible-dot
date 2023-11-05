---@alias HsMetaType "Function" | "Variable" | "Constant" | "Module"

---@class HsItemMeta
---@field name string
---@field type HsMetaType
---@field desc string
---@field notes string[] | nil
---@field parameters string[] | nil
---@field returns string[] | nil

---@class HsModuleMeta
---@field name string
---@field type HsMetaType
---@field desc string
---@field items HsItemMeta[]

---@alias HsDoc HsModuleMeta[]

---@class LualsDocSpoon
local M = {}

---@class LualsDocSpoon.Config
---@field annotationPath string dir to write lua type annotations
M.config = {}

---generate lua annotations for installed spoons
---@package
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
    error(string.format("Fail to open file '%s': %s", fileName, err))
  end
  io.output(fd)
  io.write("spoon = {\n")
  io.write(spoonDefs)
  io.write("}\n")
  io.close(fd)
end

---generate lua annotations for module item
---@param item HsItemMeta
function M.processItem(item)
  if item.desc then
    io.write("\n---" .. item.desc)
  end
  for _, note in ipairs(item.notes or {}) do
    io.write("\n---" .. note)
  end
  if item.type == "Function" then
    local params = hs.fnutils.imap(item.parameters or {}, function(param)
      local name, desc = string.match(param, "%s*(%a+)%s*-%s*(.+)")
      return {
        name = name,
        desc = desc,
      }
    end)
    local signature = ""
    for _, param in ipairs(params or {}) do
      io.write(string.format("\n---@param %s any %s", param.name, param.desc))
      if signature == "" then
        signature = param.name
      else
        signature = signature .. ", " .. param.name
      end
    end
    for i, ret in ipairs(item.returns or {}) do
      local desc = string.match(ret, "%s*%*%s*(.+)")
      if string.lower(desc) ~= "none" then
        io.write(string.format("\n---@return any ret%d %s", i, desc))
      end
    end
    io.write(string.format("\nfunction M.%s(%s) end\n", item.name, signature))
  end
end

---generate lua annotations for single module
---@param module HsModuleMeta
function M.processModule(module)
  io.write("-- " .. module.desc .. "\n")
  io.write("---@class " .. module.name .. "\n")
  io.write("local M = {}\n")
  io.write(module.name .. " = M\n")

  for _, item in ipairs(module.items) do
    M.processItem(item)
  end
end

---generate lua annotations for hammerspoon
---@package
function M:genDocForHammerspoon()
  local docPath = hs.docstrings_json_file
  local mtime = hs.fs.attributes(docPath, "modification")
  ---@type HsDoc | nil
  local docData = hs.json.read(docPath)
  if not docData then
    error("Fail to load hammerspoon doc")
  end
  for _, module in ipairs(docData) do
    if module.type ~= "Module" then
      error("Expected a module, but found type=" .. module.type)
    end
    if module.name == "hs.alert" then
      local fname = string.format("%s/%s.lua", self.config.annotationPath, module.name)
      local fmtime = hs.fs.attributes(fname, "modification")
      if fmtime == nil or mtime <= fmtime then
        local fd, err = io.open(fname, "w+")
        if not fd or err then
          error(string.format("Fail to open file '%s': %s", fname, err))
        end
        io.output(fd)
        M.processModule(module)
        io.close(fd)
      end
    end
  end
end

function M:start()
  hs.fs.mkdir(self.config.annotationPath)
  M:genDocForSpoons()
  M:genDocForHammerspoon()
end

function M:init()
  self.config = {
    annotationPath = hs.spoons.resourcePath("../../annotations"),
  }
end

return M
