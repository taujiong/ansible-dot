local wk = require("which-key")
local icons = require("user.icons")

wk.register({
  j = { "v:count == 0 ? 'gj' : 'j'", "Move cursor down", expr = true, },
  k = { "v:count == 0 ? 'gk' : 'k'", "Move cursor up", expr = true, },
  x = { '"_x', "Cut char without copy", },
  xx = { '"_dd', "Cut line without copy", },
  gx = { require("user.utils").open_with_system, "Open with system app", },
  ["\\"] = { "<cmd>split<cr>", "Split horizontally", },
  ["|"] = { "<cmd>vsplit<cr>", "Split vertically", },
  ["<m-j>"] = { "<cmd>m .+1<cr>==", "Move line down", },
  ["<m-k>"] = { "<cmd>m .-2<cr>==", "Move line up", },
  ["<c-h>"] = { "<c-w>h", "Go to left window", },
  ["<c-j>"] = { "<c-w>j", "Go to lower window", },
  ["<c-k>"] = { "<c-w>k", "Go to upper window", },
  ["<c-l>"] = { "<c-w>l", "Go to right window", },
  ["<c-s>"] = { "<cmd>w<cr>", "Save file", },
})

wk.register({
  jk = { "<esc>", "Back to normal mode", },
  ["<m-j>"] = { "<esc><cmd>m .+1<cr>==gi", "Move line down", },
  ["<m-k>"] = { "<esc><cmd>m .-2<cr>==gi", "Move line up", },
  ["<c-s>"] = { "<esc><cmd>w<cr>==gi", "Save file", },
}, { mode = "i", })

wk.register({
  f = { name = icons.Search .. " Find", },
  g = { name = icons.Git .. " Git", },
  l = {
    name = icons.ActiveLSP .. " Lsp",
    g = { "<cmd>LspLog<cr>", "Show lsp log", },
    m = { "<cmd>LspRestart<cr>", "Restart lsp", },
  },
  p = {
    name = icons.Package .. " Packages",
    m = { "<cmd>Mason<cr>", "Show mason packages", },
    s = { "<cmd>Lazy<cr>", "Show lazy plugins", },
    c = { "<cmd>Neoconf<cr>", "Update local/global neoconf", },
    l = { "<cmd>Neoconf lsp<cr>", "Show lsp settings", },
    n = { "<cmd>Neoconf show<cr>", "Show merged neoconf", },
  },
  q = { "<cmd>q<cr>", "Quit", },
}, { prefix = "<leader>", })
