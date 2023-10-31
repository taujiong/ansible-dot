return {
  fallthrough = false,

  -- macro recording
  {
    condition = function()
      return vim.fn.reg_recording() ~= ""
    end,
    update = { "RecordingEnter", "RecordingLeave" },
    provider = function()
      local register = vim.fn.reg_recording()
      return register ~= "" and require("user.icons").Heirline.MacroRecording .. " @" .. register
    end,
  },

  -- search count
  {
    condition = function()
      return vim.v.hlsearch ~= 0
    end,
    provider = function()
      local search = vim.fn.searchcount()
      if type(search) == "table" and search.total then
        local count_str = string.format(
          "%s%d/%s%d",
          search.current > search.maxcount and ">" or "",
          math.min(search.current, search.maxcount),
          search.incomplete == 2 and ">" or "",
          math.min(search.total, search.maxcount)
        )
        return require("user.icons").WhichKeyPrefix.Search .. " " .. count_str
      end
    end,
  },
}
