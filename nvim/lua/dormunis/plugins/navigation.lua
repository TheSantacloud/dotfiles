return {
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            vim.keymap.set("n", "T", function()
                if vim.fn.getqflist({ winid = 0 }).winid ~= 0 then
                    vim.cmd('cclose')
                else
                    vim.cmd('TodoQuickFix')
                end
            end, { desc = "TODO quickfix" }),
            vim.keymap.set("n", "]t", function()
                require("todo-comments").jump_next()
            end, { desc = "Next todo comment" }),

            vim.keymap.set("n", "[t", function()
                require("todo-comments").jump_prev()
            end, { desc = "Previous todo comment" }),
        }
    },
    {
        'nvim-telescope/telescope.nvim',
        event = "VeryLazy",
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
        config = function()
            require('telescope').setup {
                defaults = {
                    file_ignore_patterns = { 'node_modules', 'vendor', '%.git', "%.png", "%.jpg", "%.gif", "%.webp" },
                }
            }
            local builtin = require('telescope.builtin')
            local utils = require('telescope.utils')

            -- project navigation
            vim.keymap.set('n', '<leader><tab>', function() builtin.find_files({ hidden = true }) end,
                { desc = 'Find files (filtered to roughly relevant files)' })
            vim.keymap.set('n', '<leader>ff', builtin.git_files, { desc = 'Find files in git repo' })
            vim.keymap.set('n', '<leader>gl', builtin.git_commits, { desc = 'Git log (telescope)' })
            vim.keymap.set('n', '<leader>gL', builtin.git_bcommits, { desc = 'Git log for current buffer (telescope)' })
            vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find currently running buffers' })
            vim.keymap.set('n', '<leader>fr', function() builtin.oldfiles({ cwd = utils.buffer_dir() }) end,
                { desc = 'Find recently opened files' })
            vim.keymap.set('n', '<leader>fc', builtin.current_buffer_fuzzy_find, { desc = 'Find in Current buffer' })
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Find Grep on all files from project root' })
            vim.keymap.set('n', '<leader>fw', function()
                builtin.grep_string({ search = vim.fn.expand('<cword>') })
            end, { desc = 'Find Word - fuzzy search word under cursor' })

            -- telescope builtin help
            vim.keymap.set('n', '<leader>hh', builtin.help_tags, { desc = 'Find Help - fuzzy search help' })
            vim.keymap.set('n', '<leader>hk', builtin.keymaps, { desc = 'Find Keymaps - fuzzy search keymaps' })
        end,
    },
    {
        'ThePrimeagen/harpoon',
        branch = 'harpoon2',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim',
        },
        config = function()
            local harpoon = require('harpoon')
            harpoon:setup({
                settings = {
                    save_on_toggle = true,
                    save_on_change = true,
                },
            })

            vim.keymap.set("n", "<leader>=", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
                { desc = "Open harpoon window" })
            vim.keymap.set("n", "+", function()
                harpoon:list():append()
                vim.notify("Marked current file", vim.log.levels.INFO)
            end, { desc = "Mark current file" })
            vim.keymap.set("n", "=", function() harpoon:list():next({ ui_nav_wrap = true }) end,
                { desc = "Navigate to previous marked file", silent = true, noremap = true })
            vim.keymap.set("n", "=1", function() harpoon:list():select(1) end,
                { desc = "Navigate harpoon ID 1", silent = true, noremap = true })
            vim.keymap.set("n", "=2", function() harpoon:list():select(2) end,
                { desc = "Navigate harpoon ID 2", silent = true, noremap = true })
            vim.keymap.set("n", "=3", function() harpoon:list():select(3) end,
                { desc = "Navigate harpoon ID 3", silent = true, noremap = true })
            vim.keymap.set("n", "=4", function() harpoon:list():select(4) end,
                { desc = "Navigate harpoon ID 4", silent = true, noremap = true })
            vim.keymap.set("n", "=5", function() harpoon:list():select(5) end,
                { desc = "Navigate harpoon ID 5", silent = true, noremap = true })
            vim.keymap.set("n", "=6", function() harpoon:list():select(6) end,
                { desc = "Navigate harpoon ID 6", silent = true, noremap = true })
            vim.keymap.set("n", "=7", function() harpoon:list():select(7) end,
                { desc = "Navigate harpoon ID 7", silent = true, noremap = true })
        end,
    },
    {
        "stevearc/oil.nvim",
        dependencies = { { "echasnovski/mini.icons", opts = {} } },
        config = function()
            require("oil").setup()
            vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
        end,
    }
}
