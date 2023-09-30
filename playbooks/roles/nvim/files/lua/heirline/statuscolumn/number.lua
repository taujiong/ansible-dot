return {
  provider = function()
    local num, relnum = vim.opt.number:get(), vim.opt.relativenumber:get()
    local lnum, rnum, virtnum = vim.v.lnum, vim.v.relnum, vim.v.virtnum
    if not num and not relnum then
      return ""
    elseif virtnum ~= 0 then
      return "%="
    else
      local cur = relnum and (rnum > 0 and rnum or (num and lnum or 0)) or lnum
      return "%=" .. cur
    end
  end,
}
