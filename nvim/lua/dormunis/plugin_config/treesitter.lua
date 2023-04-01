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

