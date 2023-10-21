local wk = require("which-key")
local icons = require("user.icons")

wk.register({
  j = { "v:count == 0 ? 'gj' : 'j'", "Move cursor down", expr = true },
  k = { "v:count == 0 ? 'gk' : 'k'", "Move cursor up", expr = true },
  x = { '"_x', "Cut char without copy" },
  xx = { '"_dd', "Cut line without copy" },
  ["<tab>"] = { "<cmd>bn<cr>", "Next buffer" },
  ["<s-tab>"] = { "<cmd>bp<cr>", "Previous buffer" },
  ["\\"] = { "<cmd>split<cr>", "Split horizontally" },
  ["|"] = { "<cmd>vsplit<cr>", "Split vertically" },
  ["<m-j>"] = { "<cmd>m .+1<cr>==", "Move line down" },
  ["<m-k>"] = { "<cmd>m .-2<cr>==", "Move line up" },
  ["<c-h>"] = { "<c-w>h", "Go to left window" },
  ["<c-j>"] = { "<c-w>j", "Go to lower window" },
  ["<c-k>"] = { "<c-w>k", "Go to upper window" },
  ["<c-l>"] = { "<c-w>l", "Go to right window" },
  ["<c-s>"] = { "<cmd>w<cr>", "Save file" },
})

wk.register({
  jk = { "<esc>", "Back to normal mode" },
  ["<m-j>"] = { "<esc><cmd>m .+1<cr>==gi", "Move line down" },
  ["<m-k>"] = { "<esc><cmd>m .-2<cr>==gi", "Move line up" },
  ["<c-s>"] = { "<esc><cmd>w<cr>==gi", "Save file" },
}, { mode = "i" })

wk.register({
  b = {
    name = require("user.icons").WhichKeyPrefix.Tab .. " Buffers",
    ["\\"] = {
      function()
        require("user.utils.buffer").pick_buffer_to(function(bufnr)
          vim.cmd.split()
          vim.api.nvim_win_set_buf(0, bufnr)
        end)
      end,
      "Horizontal split buffer from tabline",
    },
    ["|"] = {
      function()
        require("user.utils.buffer").pick_buffer_to(function(bufnr)
          vim.cmd.vsplit()
          vim.api.nvim_win_set_buf(0, bufnr)
        end)
      end,
      "Vertical split buffer from tabline",
    },
    a = { require("user.utils.buffer").close_all, "Close all buffers" },
    b = { require("user.utils.buffer").pick_buffer_to_open, "Pick to open" },
    d = { require("user.utils.buffer").pick_buffer_to_close, "Pick to close" },
    l = { require("user.utils.buffer").close_left, "Close left buffers" },
    o = {
      function()
        require("user.utils.buffer").close_all(true)
      end,
      "Close others buffers",
    },
    r = { require("user.utils.buffer").close_right, "Close right buffers" },
    t = { require("user.utils.buffer").close_tab, "Close current tab" },
  },
  c = { require("user.utils.buffer").close, "Close buffer" },
  f = { name = icons.WhichKeyPrefix.Search .. " Find" },
  g = { name = icons.WhichKeyPrefix.Git .. " Git" },
  l = {
    name = icons.WhichKeyPrefix.ActiveLSP .. " Lsp",
    g = { "<cmd>LspLog<cr>", "Show lsp log" },
    m = { "<cmd>LspRestart<cr>", "Restart lsp" },
    t = { "<cmd>InspectTree<cr>", "Show syntax tree" },
    q = { "<cmd>EditQuery<cr>", "Query syntax tree" },
  },
  p = {
    name = icons.WhichKeyPrefix.Package .. " Packages",
    m = { "<cmd>Mason<cr>", "Show mason packages" },
    s = { "<cmd>Lazy<cr>", "Show lazy plugins" },
    c = { "<cmd>Neoconf<cr>", "Update local/global neoconf" },
    l = { "<cmd>Neoconf lsp<cr>", "Show lsp settings" },
    n = { "<cmd>Neoconf show<cr>", "Show merged neoconf" },
  },
  q = { "<cmd>close<cr>", "Quit" },
  u = {
    name = require("user.icons").WhichKeyPrefix.Window .. " UI/UX",
    c = { require("user.utils.ui").toggle_cmp, "Toggle autocompletion" },
    p = { require("user.utils.ui").toggle_autopairs, "Toggle autopairs" },
    r = { require("user.utils.ui").toggle_relative_number, "Toggle relative number" },
    w = { require("user.utils.ui").toggle_wrap, "Toggle wrap" },
  },
}, { prefix = "<leader>" })
