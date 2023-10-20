local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local namespace = vim.api.nvim_create_namespace

vim.on_key(function(char)
  if vim.fn.mode() == "n" then
    local new_hlsearch = vim.tbl_contains({ "<CR>", "n", "N", "*", "#", "?", "/" }, vim.fn.keytrans(char))
    if vim.opt.hlsearch:get() ~= new_hlsearch then
      vim.opt.hlsearch = new_hlsearch
    end
  end
end, namespace("auto_hlsearch"))

autocmd("BufReadPre", {
  desc = "Disable certain functionality on very large files",
  group = augroup("user_large_buf", { clear = true }),
  callback = function(args)
    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(args.buf))
    vim.b[args.buf].large_buf = (ok and stats and stats.size > vim.g.max_file.size)
      or vim.api.nvim_buf_line_count(args.buf) > vim.g.max_file.lines
  end,
})

autocmd("BufWinEnter", {
  desc = "Make q close help, man, quickfix, dap floats",
  group = augroup("user_q_close_windows", { clear = true }),
  callback = function(args)
    local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })
    if
      vim.tbl_contains({ "help", "nofile", "quickfix", "acwrite", "nowrite" }, buftype)
      and vim.fn.maparg("q", "n") == ""
    then
      vim.keymap.set("n", "q", "<cmd>close<cr>", {
        desc = "Close window",
        buffer = args.buf,
        silent = true,
        nowait = true,
      })
    end
  end,
})

autocmd("TextYankPost", {
  desc = "Highlight yanked text",
  group = augroup("user_highlight_on_yank", { clear = true }),
  pattern = "*",
  callback = function()
    vim.highlight.on_yank()
  end,
})

local view_group = augroup("user_auto_view", { clear = true })
autocmd({ "BufWritePost", "BufLeave" }, {
  desc = "Save view with mkview for real files",
  group = view_group,
  callback = function()
    vim.cmd.mkview({ mods = { emsg_silent = true } })
  end,
})
autocmd("BufEnter", {
  desc = "Try to load file view if available and enable view saving for real files",
  group = view_group,
  callback = function()
    vim.cmd.loadview({ mods = { emsg_silent = true } })
  end,
})
