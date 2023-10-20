return {
  provider = function()
    local symbols = require("aerial").get_location(false) or {}
    if #symbols == 0 then
      return ""
    end

    local sep = string.format(" %s ", require("user.icons").Heirline.sep)
    local segments = vim.tbl_map(function(symbol)
      local icon = require("user.icons").LspKind[symbol.kind]
      return string.format("%s%s", icon, symbol.name)
    end, symbols)
    local str = vim.fn.join(segments, sep)

    return sep .. str
  end,
}
