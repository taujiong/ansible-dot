return {
  init = function(self)
    self.mode = vim.fn.mode(1)
  end,
  static = {
    max_length = 9, -- longest mode name length plus 2
    mode_names = {
      n = "Normal",
      no = "Op",
      nov = "Op",
      noV = "Op",
      ["no\22"] = "Op",
      niI = "Normal",
      niR = "Normal",
      niV = "Normal",
      nt = "Term",
      v = "Visual",
      vs = "Visual",
      V = "Visual",
      Vs = "Visual",
      ["\22"] = "Visual",
      ["\22s"] = "Visual",
      s = "Select",
      S = "Select",
      ["\19"] = "Select",
      i = "Insert",
      ic = "Insert",
      ix = "Insert",
      R = "Replace",
      Rc = "Replace",
      Rx = "Replace",
      Rv = "Replace",
      Rvc = "Replace",
      Rvx = "Replace",
      c = "Command",
      cv = "Command",
      r = "Prompt",
      rm = "More",
      ["r?"] = "Confirm",
      ["!"] = "Shell",
      t = "Term",
    },
    mode_colors = {
      ["Normal"] = "darken_blue",
      ["Op"] = "darken_blue",
      ["Visual"] = "darken_pink",
      ["Select"] = "darken_pink",
      ["Insert"] = "darken_teal",
      ["Replace"] = "darken_teal",
      ["Prompt"] = "darken_teal",
      ["Confirm"] = "darken_teal",
      ["Term"] = "darken_mauve",
      ["Command"] = "darken_mauve",
      ["More"] = "darken_mauve",
      ["Shell"] = "darken_mauve",
    },
  },
  provider = function(self)
    local mode_name = self.mode_names[self.mode]
    local padding = self.max_length - #mode_name
    return string.rep(" ", math.floor(padding / 2)) .. mode_name .. string.rep(" ", math.floor(padding / 2))
  end,
  hl = function(self)
    local mode_color = self.mode_colors[self.mode_names[self.mode]]
    return { bg = mode_color, bold = true, }
  end,
}
