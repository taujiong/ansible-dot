local M = {}

function M.close(bufnr)
  if not bufnr or bufnr == 0 then bufnr = vim.api.nvim_get_current_buf() end
  local delete_cmd = vim.api.nvim_get_option_value("modified", { buf = bufnr, }) and "confirm bdelete" or "bdelete!"
  vim.cmd(("silent! %s %d"):format(delete_cmd, bufnr))
end

function M.close_all(kepp_current)
  local current = vim.api.nvim_get_current_buf()
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if not kepp_current or bufnr ~= current then
      M.close(bufnr)
    end
  end
end

function M.close_left()
  local current = vim.api.nvim_get_current_buf()
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if bufnr == current then break end
    M.close(bufnr)
  end
end

function M.close_right()
  local current = vim.api.nvim_get_current_buf()
  local after_current = false
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if after_current then M.close(bufnr) end
    if bufnr == current then after_current = true end
  end
end

function M.close_tab()
  if #vim.api.nvim_list_tabpages() > 1 then
    vim.cmd.tabclose()
  end
end

function M.pick_buffer_to(callback)
  local tabline = require("heirline").tabline
  local prev_showtabline = vim.opt.showtabline:get()
  if prev_showtabline ~= 2 then vim.opt.showtabline = 2 end
  vim.cmd.redrawtabline()
  ---@diagnostic disable-next-line: undefined-field
  local buflist = tabline and tabline._buflist and tabline._buflist[1]
  if buflist then
    buflist._picker_labels = {}
    buflist._show_picker = true
    vim.cmd.redrawtabline()
    local char = vim.fn.getcharstr()
    local bufnr = buflist._picker_labels[char]
    if bufnr then callback(bufnr) end
    buflist._show_picker = false
  end
  if prev_showtabline ~= 2 then vim.opt.showtabline = prev_showtabline end
  vim.cmd.redrawtabline()
end

function M.pick_buffer_to_open()
  M.pick_buffer_to(function(bufnr)
    vim.cmd("b" .. bufnr)
  end)
end

function M.pick_buffer_to_close()
  M.pick_buffer_to(function(bufnr)
    M.close(bufnr)
  end)
end

return M
