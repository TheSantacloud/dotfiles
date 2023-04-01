return {
    'nvim-treesitter/nvim-treesitter',
    build = function()
        pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function ()
        require'nvim-treesitter.configs'.setup {
            ensure_installed = {
                "c",
                "lua",
                "vim",
                "help",
                "query",
                "python",
                "javascript",
                "typescript",
                "rust"
            },
            sync_install = false,
            auto_install = true,
            highlight = {
                enable = true,
            },
        }
    end
}
