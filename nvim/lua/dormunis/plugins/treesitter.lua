return {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    event = { "BufRead", "BufNewFile" },
    dependencies = {
        'nvim-treesitter/nvim-treesitter-context',
        'nvim-treesitter/nvim-treesitter-refactor',
    },
    config = function()
        ---@diagnostic disable-next-line: missing-fields
        require('nvim-treesitter.configs').setup {
            refactor = {
                highlight_definitions = {
                    enable = true,
                    clear_on_cursor_move = true,
                },
            },
            ensure_installed = {
                "c",
                "lua",
                "go",
                "vim",
                "query",
                "python",
                "javascript",
                "typescript",
                "rust",
                "terraform",
                "hcl",
                "arduino",
                "cpp",
                "css",
                "dockerfile",
                "html",
                "json",
                "make",
                "regex",
                "scala",
                "toml",
                "java",
                "sql",
                "bash",
                "yaml",
                "markdown_inline",
                "zig",
            },
            sync_install = false,
            auto_install = true,
            -- indent = { enable = true },
            highlight = {
                enable = true,
            },
        }
    end
}
