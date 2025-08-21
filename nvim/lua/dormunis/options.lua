vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.o.guicursor = ""
vim.o.cursorline = true
vim.o.showcmd = true
vim.o.laststatus = 2
vim.o.autowrite = true
vim.o.autoread = true

vim.o.nu = true
vim.o.relativenumber = true

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.shiftround = true
vim.o.expandtab = true

vim.o.smartindent = true
vim.o.backspace = "indent,eol,start"

vim.o.wrap = false

vim.o.swapfile = false
vim.o.backup = false
vim.o.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.o.undofile = true

-- :e to create a file in the current directory
-- TODO: make this work for only :e
-- vim.o.autochdir = true

vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.termguicolors = true
vim.o.showmode = false

vim.o.scrolloff = 8
vim.o.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.o.updatetime = 50

vim.o.colorcolumn = "100"

-- disable startup screen
vim.opt.shortmess:append({ I = true })

-- split behavior
vim.o.splitright = true
vim.o.splitbelow = true

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.hl.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

-- Remove all trailing whitespace on save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})

vim.opt.completeopt = { "menu", "menuone", "noselect" }
