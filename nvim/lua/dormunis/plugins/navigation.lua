---@diagnostic disable: missing-fields
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
    "ibhagwan/fzf-lua",
    event = "VeryLazy",
    dependencies = { "echasnovski/mini.icons" },
    opts = {
      files = {
        prompt = "Files> ",
        fd_opts = "--color=never --hidden --exclude .git --exclude node_modules --exclude vendor",
      },
      grep = {
        prompt = "Grep> ",
        rg_opts = "--color=never --hidden --exclude .git --exclude node_modules --exclude vendor",
      },
      keymap = {
        builtin = {
        }
      }
    },
    config = function()
      local fzf = require("fzf-lua")
      fzf.setup({
        "hide",
        keymap = {
          fzf = {
            ["ctrl-q"] = "select-all+accept",
          },
        },
      })
      local map = vim.keymap.set
      map('n', '<leader><tab>', fzf.files, { desc = 'Find files (hidden included)' })
      map('n', '<leader>ff', fzf.git_files, { desc = 'Find git-tracked files' })
      map('n', '<leader>fb', fzf.buffers, { desc = 'Open buffers' })
      map('n', '<leader>fr', fzf.oldfiles, { desc = 'Recently opened files' })
      map('n', '<leader>fg', fzf.live_grep, { desc = 'Live grep project' })
      map('n', '<leader>fw', fzf.grep_cword, { desc = 'Grep word under cursor' })
      map('n', '<leader>gl', fzf.git_commits, { desc = 'Git commits' })
      map('n', '<leader>gL', fzf.git_bcommits, { desc = 'Git commits (current buffer)' })
      map('n', '<leader>fd', fzf.lsp_workspace_symbols, { desc = 'LSP workspace symbols' })
      map('n', '<leader>fc', fzf.blines, { desc = 'Search in current buffer' })
      map('n', '<leader>hh', fzf.help_tags, { desc = 'Help tags' })
      map('n', '<leader>hk', fzf.keymaps, { desc = 'Keymaps' })
    end
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
