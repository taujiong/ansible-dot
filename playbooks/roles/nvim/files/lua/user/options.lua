local options = {
  ---@type vim.go | vim.wo | vim.bo
  o = {
    -- go
    backspace = "indent,eol,start,nostop",
    clipboard = "unnamedplus",
    cmdheight = 0,
    diffopt = "internal,filler,closeoff,linematch:60",
    foldlevelstart = 99,
    history = 100,
    ignorecase = true,
    laststatus = 3,
    mouse = "a",
    pumheight = 10,
    shortmess = "filnxsoOFtTI",
    showmode = false,
    showtabline = 2,
    smartcase = true,
    splitbelow = true,
    splitright = true,
    termguicolors = true,
    timeoutlen = 500,
    titlestring = "%t - nvim",
    updatetime = 300,
    wildmenu = true,
    wildmode = "longest:list,full",
    writebackup = false,
    -- wo
    breakindent = false,
    cursorline = true,
    fillchars = "eob: ",
    foldenable = true,
    foldlevel = 99,
    foldcolumn = "1",
    linebreak = true,
    list = true,
    listchars = "tab:│→,extends:⟩,precedes:⟨,trail:·,nbsp:␣",
    number = true,
    relativenumber = true,
    scrolloff = 8,
    showbreak = "↪ ",
    sidescrolloff = 8,
    signcolumn = "yes",
    virtualedit = "block",
    wrap = true,
    -- bo
    expandtab = true,
    fileencoding = "utf-8",
    infercase = true,
    shiftwidth = 2,
    swapfile = false,
    tabstop = 2,
    undofile = true,
  },
  g = {
    mapleader = " ",
    maplocalleader = " ",
    loaded_netrw = 1,
    loaded_netrwPlugin = 1,
    -- customize
    max_file = {
      size = 1024 * 100,
      lines = 10000,
    },
    autoformat_enabled = true,
  },
}

for scope, table in pairs(options) do
  for setting, value in pairs(table) do
    vim[scope][setting] = value
  end
end
