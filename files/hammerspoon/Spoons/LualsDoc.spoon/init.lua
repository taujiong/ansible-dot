---@alias HsMetaType "Function" | "Variable" | "Constant" | "Module" | "Constructor" | "Method"

---@class HsItemMeta
---@field name string
---@field type HsMetaType
---@field desc string
---@field doc string
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

---convert into comment string
---@param str string raw string
---@param noCommentPrefix? boolean do not add comment prefix
---@param noTrailingNewline? boolean dot not add trailing new line
---@return string commented commented string
function M.comment(str, noCommentPrefix, noTrailingNewline)
  local commentStr = "--"
  local prefix = noCommentPrefix and "" or commentStr .. " "
  local trailing = noTrailingNewline and "" or "\n"
  return prefix .. str:gsub("[\n]", "\n" .. commentStr .. " "):gsub("%s+\n", "\n") .. trailing
end

---generate lua annotations for module item
---@package
---@param item HsItemMeta
function M.processItem(item)
  -- write summary
  local summary = item.desc
  if item.type == "Constant" or item.type == "Variable" then
    summary = item.doc
  end
  if summary then
    io.write(M.comment(summary))
  end

  -- write extra note
  for _, note in ipairs(item.notes or {}) do
    io.write(M.comment(note))
  end

  -- write params
  local params = hs.fnutils.imap(item.parameters or {}, function(param)
    local name, desc = string.match(param, "%s*(%a+)%s*-%s*(.+)")
    if name == "end" then
      name = "_end"
    end
    return {
      name = name,
      desc = desc,
    }
  end)
  local signature = ""
  for _, param in ipairs(params or {}) do
    if param.name and param.desc then
      io.write(string.format("---@param %s any %s\n", param.name, M.comment(param.desc, true, true)))
      if signature == "" then
        signature = param.name
      else
        signature = signature .. ", " .. param.name
      end
    end
  end

  -- write returns
  for i, ret in ipairs(item.returns or {}) do
    local desc = string.match(ret, "%s*%*%s*(.+)")
    if not desc then
      io.write(M.comment(ret))
    elseif string.lower(desc) ~= "none" then
      io.write(string.format("---@return any ret%d %s\n", i, desc))
    end
  end

  -- write signature
  if item.type == "Function" or item.type == "Constructor" then
    io.write(string.format("function M.%s(%s) end\n", item.name, signature))
  elseif item.type == "Method" then
    io.write(string.format("function M:%s(%s) end\n", item.name, signature))
  else
    io.write(string.format("M.%s = nil\n", item.name))
  end
end

---generate lua annotations for single module
---@package
---@param module HsModuleMeta
function M.processModule(module)
  io.write("---@diagnostic disable: unused-local\n\n")
  io.write("-- " .. module.desc .. "\n")
  io.write("---@class " .. module.name .. "\n")
  io.write("local M = {}\n")
  io.write(module.name .. " = M\n")

  for _, item in ipairs(module.items) do
    io.write("\n")
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
    local fname = string.format("%s/%s.lua", self.config.annotationPath, module.name)
    local fmtime = hs.fs.attributes(fname, "modification")
    if fmtime == nil or mtime > fmtime then
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
