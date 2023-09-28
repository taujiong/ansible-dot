return {
  condition = function()
    return require("heirline.conditions").lsp_attached()
  end,
  update = { "LspAttach", "LspDetach", "BufEnter", },
  provider = function()
    local names = {}
    for _, server in ipairs(vim.lsp.get_active_clients({ bufnr = 0, })) do
      table.insert(names, server.name)
    end
    return require("user.icons").ActiveLSP .. " " .. table.concat(names, ", ")
  end,
}
