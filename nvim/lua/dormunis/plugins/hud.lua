return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                options = {
                    theme = "auto",
                    fmt = string.lower,
                },
                sections = {
                    lualine_a = { "branch" },
                    lualine_b = {
                        {
                            "filename",
                            path = 1,
                        }
                    },
                    lualine_c = {
                        {
                            "diagnostics",
                            sources = { "nvim_diagnostic", "coc" },
                            sections = { "error", "warn", "info", "hint" },
                            diagnostics_color = {
                                error = "DiagnosticError",
                                warn = "DiagnosticWarn",
                                info = "DiagnosticInfo",
                                hint = "DiagnosticHint",
                            },
                            symbols = { error = "E", warn = "W", info = "I", hint = "H" },
                            colored = true,
                            update_in_insert = false,
                            always_visible = false,
                        },
                    },
                    lualine_x = { "encoding", "fileformat", "filetype" },
                    lualine_y = { "progress" },
                    lualine_z = { "location" },
                },
            })
        end,
    },
    {
        "folke/which-key.nvim",
        dependencies = { "echasnovski/mini.icons" },
        event = "VeryLazy",
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local Keymaps (which-key)",
            },
        },
    },
}
