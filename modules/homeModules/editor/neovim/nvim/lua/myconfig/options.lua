local globals = {
  mapleader = " ",
  maplocalleader = " ",
  have_nerd_font = true,
  editorconfig = true,
}

for k, v in pairs(globals) do
  vim.g[k] = v
end

vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)

local options = {
  number = true,
  relativenumber = true,
  mouse = "a",
  showmode = false,
  breakindent = true, -- Continue indented wrapped line at same level
  undofile = true,
  undodir = vim.fn.stdpath("state") .. "/undo",
  writebackup = false,
  signcolumn = "yes",
  swapfile = false,
  updatetime = 250,
  timeoutlen = 300,
  splitright = true,
  splitbelow = true,
  list = true,
  inccommand = "split",
  cursorline = true,
  scrolloff = 10,
  confirm = true,
  expandtab = true,
  hidden = true,
  shiftwidth = 0,
  tabstop = 2,
  -- smartindent = true,
  jumpoptions = "stack,view",
  winborder = "rounded",
  termguicolors = true,
  cursorlineopt = "both",
  smoothscroll = true,

  foldenable = false,
  foldmethod = "indent",

  -- round to the nearest indentation level when using '<' and '>'
  shiftround = true,

  -- Don't depend on cindent or smartindent
  autoindent = true,

  -- Set nowrap
  wrap = false,

  -- Search
  ignorecase = true,
  smartcase = true,
  hlsearch = true,

  -- statusline
  showcmd = true,

  -- Only one statusline, for better separator between horizontal splits
  laststatus = 3,

  -- Formatting

  -- Continue line comments in all languages. Without adding `ro`, it only seemed
  -- to work in some languages. Keep `t`, so text width also applies to something
  -- like markdown
  formatoptions = "tcqjro/",

  -- Auto-wrap comments (but not other stuff, thanks to the `t` changes above)
  textwidth = 80,

  backup = false,
}
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.cmd("syntax on")
