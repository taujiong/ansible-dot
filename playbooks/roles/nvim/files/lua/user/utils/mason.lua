local M = {}

---@param packages string[] ensure installed mason packages
function M.ensure_mason_package_installed(packages)
  local mason_registry = require("mason-registry")
  for _, package in ipairs(packages) do
    local ok, pkg = pcall(mason_registry.get_package, package)
    if not ok then
      vim.notify("mason can not install package " .. package, vim.log.levels.WARN)
    else
      if not pkg:is_installed() then
        vim.notify(("[mason] installing %s"):format(pkg.name))
        pkg:install():once(
          "closed",
          vim.schedule_wrap(function()
            if pkg:is_installed() then
              vim.notify(("[mason] %s was installed"):format(pkg.name))
            end
          end)
        )
      end
    end
  end
end

return M
