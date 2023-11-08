local wezterm = require("wezterm")
local config = wezterm.config_builder()

for _, path in ipairs(wezterm.glob("*.lua", wezterm.config_dir)) do
  local moduleName = path:match("(%a+).lua")
  local ok, module = pcall(require, moduleName)
  if not ok or not module then
    error("Fail to load module: " .. path)
  end
  if module.config then
    module.config(config)
  end
end

return config
