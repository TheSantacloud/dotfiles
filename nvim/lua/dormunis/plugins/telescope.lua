return {
    'nvim-telescope/telescope.nvim',
    event = "VeryLazy",
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    config = function()
        require('telescope').setup {
            defaults = {
                file_ignore_patterns = { 'node_modules', 'vendor', '%.git' },
            }
        }
        local builtin = require('telescope.builtin')

        -- project navigation
        vim.keymap.set('n', '<leader>fa', builtin.find_files, { desc = 'Find all files from project root' })
        vim.keymap.set('n', '<Tab><Tab>', builtin.git_files, { desc = 'Find files in git repo' })
        vim.keymap.set('n', '<leader>ff', builtin.git_files, { desc = 'Find files in git repo' })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find currently running buffers' })
        vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = 'Find recently opened files' })
        vim.keymap.set('n', '<leader>fc', builtin.current_buffer_fuzzy_find, { desc = 'Find in Current buffer' })
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Find Grep on all files from project root' })
        vim.keymap.set('n', '<leader>fw', function()
            builtin.grep_string({ search = vim.fn.expand('<cword>') })
        end, { desc = 'Find Word - fuzzy search word under cursor' })

        -- telescope builtin help
        vim.keymap.set('n', '<leader>hh', builtin.help_tags, { desc = 'Find Help - fuzzy search help' })
        vim.keymap.set('n', '<leader>hk', builtin.keymaps, { desc = 'Find Keymaps - fuzzy search keymaps' })
    end,
}
