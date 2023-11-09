local M = {}

---check whether the pane is running vim
---@param pane _.wezterm.Pane wezterm pane
function M.isVim(pane)
  return pane:get_user_vars().IS_NVIM == "true"
end

---merge list
---@param currentList any[] current list
---@param newList any[] new list
---@return any[] finalList final list
function M.mergeList(currentList, newList)
  if not currentList then
    return newList
  end
  for _, item in ipairs(newList) do
    table.insert(currentList, item)
  end
  return currentList
end

return M
