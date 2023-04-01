local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    "ellisonleao/gruvbox.nvim",
    "nvim-tree/nvim-tree.lua",
    "nvim-lualine/lualine.nvim",
    'mbbill/undotree',
    'tpope/vim-fugitive',
    'github/copilot.vim',
    "nvim-tree/nvim-web-devicons",
    {
	    "goolord/alpha-nvim",
	    dependencies = "nvim-tree/nvim-web-devicons",
	    config = function()
		    require("alpha").setup(require("alpha.themes.startify").config)
	    end,
    },
    {
	    'nvim-telescope/telescope.nvim',
	    tag = '0.1.1',
	    dependencies= { {'nvim-lua/plenary.nvim'} }
    },
    {
	    'nvim-treesitter/nvim-treesitter',
	    build = function()
		    pcall(require('nvim-treesitter.install').update { with_sync = true })
	    end,
	    dependencies = {
		    'nvim-treesitter/nvim-treesitter-textobjects',
	    }
    },
    {
	    'folke/which-key.nvim',
	    config = function ()
		    vim.o.timeout = true
		    vim.o.timeoutlen = 300
		    require("which-key").setup({})
	    end,
    },
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {                                      -- Optional
            'williamboman/mason.nvim',
            build= function()
                pcall(vim.cmd, 'MasonUpdate')
            end,
        },
        {'williamboman/mason-lspconfig.nvim'}, -- Optional

        -- Autocompletion
        {'hrsh7th/nvim-cmp'},     -- Required
        {'hrsh7th/cmp-nvim-lsp'}, -- Required
        {'L3MON4D3/LuaSnip'},     -- Required
    }
    }
}

local opts = {}

require("lazy").setup(plugins, opts)
