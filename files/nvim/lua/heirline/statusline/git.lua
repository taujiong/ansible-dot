return {
  condition = function()
    return require("heirline.conditions").is_git_repo()
  end,
  init = function(self)
    self.status_dict = vim.b[0].gitsigns_status_dict
    self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
  end,
  hl = { fg = "mauve" },

  require("heirline.component").padding(2),

  -- branch
  {
    provider = function(self)
      return require("user.icons").Heirline.GitBranch .. " " .. self.status_dict.head
    end,
    hl = { bold = true },
  },

  -- add
  {
    provider = function(self)
      local count = self.status_dict.added or 0
      return count > 0 and (" " .. require("user.icons").Heirline.GitAdd .. " " .. count)
    end,
    hl = { fg = "green" },
  },

  -- remove
  {
    provider = function(self)
      local count = self.status_dict.removed or 0
      return count > 0 and (" " .. require("user.icons").Heirline.GitDelete .. " " .. count)
    end,
    hl = { fg = "red" },
  },

  -- change
  {
    provider = function(self)
      local count = self.status_dict.changed or 0
      return count > 0 and (" " .. require("user.icons").Heirline.GitChange .. " " .. count)
    end,
    hl = { fg = "yellow" },
  },
}
