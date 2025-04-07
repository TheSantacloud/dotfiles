local function run_zig_file()
  vim.cmd('VimuxRunCommand "zig build run"')
end

vim.keymap.set("n", "<space><space>r", run_zig_file)
vim.keymap.set("v", "<space><space>r", run_zig_file)
