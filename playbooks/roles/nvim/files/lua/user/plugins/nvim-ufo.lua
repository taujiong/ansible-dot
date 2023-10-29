---@type LazySpec
return {
  "kevinhwang91/nvim-ufo",
  dependencies = {
    "kevinhwang91/promise-async",
  },
  event = { "BufEnter" },
  keys = {
    {
      "zR",
      function()
        require("ufo").openAllFolds()
      end,
      desc = "Open all folds",
    },
    {
      "zM",
      function()
        require("ufo").closeAllFolds()
      end,
      desc = "Close all folds",
    },
    {
      "zr",
      function()
        require("ufo").openFoldsExceptKinds()
      end,
      desc = "Fold less",
    },
    {
      "zm",
      function()
        require("ufo").closeFoldsWith()
      end,
      desc = "Fold more",
    },
    {
      "zp",
      function()
        require("ufo").peekFoldedLinesUnderCursor()
      end,
      desc = "Peek fold",
    },
  },
  -- for all available options, refer to `:help nvim-ufo.txt`
  ---@type UfoConfig
  ---@diagnostic disable-next-line: missing-fields
  opts = {
    preview = {
      mappings = {
        scrollB = "<C-b>",
        scrollF = "<C-f>",
        scrollU = "<C-u>",
        scrollD = "<C-d>",
      },
    },
    provider_selector = function(_, filetype, buftype)
      if vim.tbl_contains({ "NeogitStatus", "NvimTree", "NeogitPopup", "aerial" }, filetype) then
        return ""
      end
      if filetype == "" or buftype == "nofile" then
        return "indent"
      end

      local function handleFallbackException(bufnr, err, providerName)
        if type(err) == "string" and err:match("UfoFallbackException") then
          return require("ufo").getFolds(bufnr, providerName)
        else
          return require("promise").reject(err)
        end
      end

      return function(bufnr)
        return require("ufo")
          .getFolds(bufnr, "lsp")
          :catch(function(err)
            return handleFallbackException(bufnr, err, "treesitter")
          end)
          :catch(function(err)
            return handleFallbackException(bufnr, err, "indent")
          end)
      end
    end,
  },
}
