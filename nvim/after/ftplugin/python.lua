vim.api.nvim_buf_set_keymap(
    0,
    'n',
    '<space><space>r',
    [[:VimuxRunCommand "python ]] .. vim.fn.expand('%:p') .. [["<CR>]],
    { noremap = true, silent = true }
)
