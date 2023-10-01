---@type LazySpec
return {
  "kevinhwang91/nvim-ufo",
  event = "VeryLazy",
  dependencies = {
    "kevinhwang91/promise-async",
  },
  -- for all available options, refer to `:help nvim-ufo.txt`
  ---@type UfoConfig
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
      if vim.tbl_contains({ "NeogitStatus", }, filetype) then return nil end
      if filetype == "" or buftype == "nofile" then return "indent" end

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
  config = function(_, opts)
    require("ufo").setup(opts)
    require("which-key").register({
      z = {
        R = { require("ufo").openAllFolds, "Open all folds", },
        M = { require("ufo").closeAllFolds, "Close all folds", },
        r = { require("ufo").openFoldsExceptKinds, "Fold less", },
        m = { require("ufo").closeFoldsWith, "Fold more", },
        p = { require("ufo").peekFoldedLinesUnderCursor, "Peek fold", },
      },
    })
  end,
}
