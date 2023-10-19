return {
  init = function(self)
    self.file_type = vim.bo[self.bufnr].filetype
    self.file_path = vim.api.nvim_buf_get_name(self.bufnr)
    self.file_name = vim.fn.fnamemodify(self.file_path, ":t")
  end,
  on_click = {
    minwid = function(self)
      return self.bufnr
    end,
    name = "heirline_tabline_buffer_click_handle",
    callback = function(_, minwid)
      vim.api.nvim_win_set_buf(0, minwid)
    end,
  },

  require("heirline.component").padding(2),

  {
    fallthrough = false,
    {
      condition = function(self)
        return self._show_picker
      end,
      update = false,
      init = function(self)
        if not (self.label and self._picker_labels[self.label]) then
          local bufname = self.file_path == "" and "Untitled" or self.file_name
          local label = bufname:sub(1, 1)
          local i = 2
          while label ~= " " and self._picker_labels[label] do
            if i > #bufname then
              break
            end
            label = bufname:sub(i, i)
            i = i + 1
          end
          self._picker_labels[label] = self.bufnr
          self.label = label
        end
      end,
      provider = function(self)
        return self.label
      end,
      hl = { fg = "red" },
    },
    require("heirline.component").file_icon(),
  },

  require("heirline.component").padding(1),

  -- file name
  {
    hl = function(self)
      if not self.is_active then
        return { fg = "darken_subtext0" }
      end
    end,

    -- extra file prefix to ensure buffer name unique
    {
      provider = function(self)
        if self.file_path == "" then
          return ""
        end
        local current
        local unique_path = ""
        local function path_parts(file_path)
          local parts = {}
          for match in (file_path .. "/"):gmatch("(.-)" .. "/") do
            table.insert(parts, match)
          end
          return parts
        end
        for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
          local file_path = vim.api.nvim_buf_get_name(bufnr)
          local file_name = vim.fn.fnamemodify(file_path, ":t")
          if self.file_name == file_name and self.bufnr ~= bufnr then
            if not current then
              current = path_parts(self.file_path)
            end
            local other = path_parts(file_path)

            for i = #current - 1, 1, -1 do
              if current[i] ~= other[i] then
                unique_path = current[i] .. "/"
                break
              end
            end
          end
        end
        return unique_path
      end,
    },

    -- file name
    {
      provider = function(self)
        return self.file_path == "" and "Untitled" or self.file_name
      end,
    },

    -- file modified indicator
    {
      provider = function(self)
        if vim.bo[self.bufnr].modified then
          return " " .. require("user.icons").Heirline.FileModified
        end
      end,
    },

    -- file read-only indicator
    {
      provider = function(self)
        local bo = vim.bo[self.bufnr]
        if not bo.modifiable or bo.readonly then
          return " " .. require("user.icons").Heirline.FileReadOnly
        end
      end,
    },
  },

  require("heirline.component").padding(2),

  -- close button
  {
    hl = function(self)
      if self.is_active then
        return { fg = "red" }
      end
    end,
    on_click = {
      minwid = function(self)
        return self.bufnr
      end,
      name = "heirline_tabline_buffer_close_click_handle",
      callback = function(_, minwid)
        require("user.utils.buffer").close(minwid)
      end,
    },
    provider = require("user.icons").Heirline.BufferClose,
  },
}
