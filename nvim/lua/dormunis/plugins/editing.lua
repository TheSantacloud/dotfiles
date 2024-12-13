return {
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup()
        end
    },
    {
        'mbbill/undotree',
        config = function()
            vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = 'Undo Tree' })
        end
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'onsails/lspkind.nvim',
            {
                'L3MON4D3/LuaSnip',
                version = "2.*",
                build = "make install_jsregexp"
            },
        },
        config = function()
            local lspkind = require("lspkind")

            local cmp = require("cmp")
            local luasnip = require("luasnip")

            luasnip.config.setup({})
            require("luasnip.loaders.from_vscode").lazy_load()

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                ---@diagnostic disable-next-line: missing-fields
                formatting = {
                    format = lspkind.cmp_format({
                        mode = "symbol_text",
                        maxwidth = 50,
                        ellipsis_char = '...',
                        show_labelDetails = true,
                    })
                },
                mapping = cmp.mapping.preset.insert({
                    ['<CR>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            if luasnip.expandable() then
                                luasnip.expand()
                            else
                                cmp.confirm({ select = true })
                            end
                        else
                            fallback()
                        end
                    end),

                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.locally_jumpable(1) then
                            luasnip.jump(1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                    ["<C-e>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.mapping.abort()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                sources = {
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "path" },
                    { name = "buffer" },
                    { name = "nvim_lsp_signature_help" },
                },
            })
        end
    },
    {
        "github/copilot.vim",
        config = function()
            vim.api.nvim_set_keymap("i", "<C-y>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
            vim.g.copilot_no_tab_map = true
        end,
    }
}
