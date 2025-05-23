require("dormunis.options")
require("dormunis.keymap")
require("dormunis.globals")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.keymap.set("n", "<leader>sl", function()
  require("lazy").home()
end, { desc = "Open Lazy" })

require("dormunis.diagnostics").setup()
require("lazy").setup("dormunis.plugins")
