return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
        -- LSP Support
        {'neovim/nvim-lspconfig'},             -- Required
        {'mfussenegger/nvim-dap'},
        {'jay-babu/mason-nvim-dap.nvim'},
        {                                      -- Optional
            'williamboman/mason.nvim',
            build= function()
                pcall(vim.cmd, 'MasonUpdate')
                require('nvim-dap').setup()
                require('mason-nvim-dap').setup()
            end,
        },
        {'williamboman/mason-lspconfig.nvim'}, -- Optional

        -- Autocompletion
        {'hrsh7th/nvim-cmp'},     -- Required
        {'hrsh7th/cmp-nvim-lsp'}, -- Required
        {'L3MON4D3/LuaSnip'},     -- Required
    },
    config = function ()
        local lsp = require('lsp-zero').preset({})

        lsp.on_attach(function(client, bufnr)
            lsp.default_keymaps({buffer = bufnr})
        end)

        lsp.ensure_installed({
            'tsserver',
            'eslint',
            'lua_ls',
            'rust_analyzer',
            'sqlls',
            'taplo',
            'yamlls',
            'lemminx',
            'terraformls',
            'tflint',
            'pylsp',
            'marksman',
            'kotlin_language_server',
            'jsonls',
            'golangci_lint_ls',
            'dockerls',
            'docker_compose_language_service',
            'cssls',
            'clangd',
            'arduino_language_server'
        })

        local cmp = require('cmp')
        local cmp_select = {behavior = cmp.SelectBehavior.Select}
        local cmp_mappings = lsp.defaults.cmp_mappings({
            ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
            ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
            ['<C-y>'] = cmp.mapping.confirm({select = true}),
            --['<C-Space>'] = cmp.mapping.complete(),
        })

        lsp.setup_nvim_cmp({
        })

        lsp.on_attach(function(client, bufnr)
            local opts = {buffer = bufnr, remap = false}

            vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
            vim.keymap.set("n", "gt", function() vim.lsp.buf.type_definition() end, opts)
            vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
            vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
            vim.keymap.set("n", "[e", function() vim.diagnostic.goto_next() end, opts)
            vim.keymap.set("n", "]e", function() vim.diagnostic.goto_previous() end, opts)
            vim.keymap.set("n", "<leader>cd", function() vim.diagnostic.open_float() end, opts)
            vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
            vim.keymap.set("n", "<leader>cr", function() vim.lsp.buf.references() end, opts)
            vim.keymap.set("n", "<leader>cR", function() vim.lsp.buf.rename() end, opts)
            vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
        end)

        -- (Optional) Configure lua language server for neovim
        require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

        lsp.setup()
    end
}
