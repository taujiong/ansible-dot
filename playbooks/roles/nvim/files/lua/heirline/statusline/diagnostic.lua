return {
  condition = function()
    return require("heirline.conditions").has_diagnostics()
  end,
  static = {
    error_icon = vim.fn.sign_getdefined("DiagnosticSignError")[1].text,
    warn_icon = vim.fn.sign_getdefined("DiagnosticSignWarn")[1].text,
    info_icon = vim.fn.sign_getdefined("DiagnosticSignInfo")[1].text,
    hint_icon = vim.fn.sign_getdefined("DiagnosticSignHint")[1].text,
  },
  init = function(self)
    self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    self.warns = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    self.infos = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
    self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
  end,
  update = { "DiagnosticChanged", "BufEnter" },

  require("heirline.component").padding(2),

  -- error
  {
    provider = function(self)
      return self.errors > 0 and (" " .. self.error_icon .. self.errors)
    end,
    hl = { fg = "red" },
  },

  -- warn
  {
    provider = function(self)
      return self.warns > 0 and (" " .. self.warn_icon .. self.warns)
    end,
    hl = { fg = "yellow" },
  },

  -- info
  {
    provider = function(self)
      return self.infos > 0 and (" " .. self.info_icon .. self.infos)
    end,
    hl = { fg = "green" },
  },

  -- hint
  {
    provider = function(self)
      return self.hints > 0 and (" " .. self.hint_icon .. self.hints)
    end,
    hl = { fg = "sapphire" },
  },
}
