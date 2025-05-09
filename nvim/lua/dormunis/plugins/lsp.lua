return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "mason-org/mason.nvim",          config = true },
    { "mason-org/mason-lspconfig.nvim" },
    { "j-hui/fidget.nvim",             opts = {} },
  },
  config = function()
    local on_attach = function(_, bufnr)
      local nmap = function(keys, func, desc)
        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
      end

      nmap("<leader>r", vim.lsp.buf.rename, "Rename")
      nmap("gD", vim.lsp.buf.declaration, "Go to declaration")
      nmap("gd", vim.lsp.buf.definition, "Go to definition")
      nmap("gr", function()
        vim.lsp.buf.references(nil, {
          on_list = function(options)
            vim.fn.setqflist({}, " ", {
              lines = options.items,
              title = "References",
            })
            vim.api.nvim_command("cfirst")
          end,
        })
      end, "Get references in a quickfix list")
      nmap("gI", vim.lsp.buf.implementation, "Go to implementation")
      nmap("gt", vim.lsp.buf.type_definition, "Go to type definition")
      nmap("K", vim.lsp.buf.hover, "Hover Documentation")
      nmap("H", vim.lsp.buf.signature_help, "Signature Help")
      nmap("<leader>cf", vim.lsp.buf.format, "Format file")
      nmap("<leader>ca", vim.lsp.buf.code_action, "Code action")
      nmap("<leader>L", ":LspRestart<CR>", "LSP Restart")
    end

    local servers = {
      "gopls",
      "rust_analyzer",
      "html",
      "sqlls",
      "helm_ls",
      "zls",
      "clangd",
      "terraformls",
      "ruff",
      "pyright",
      "lua_ls",
      "sourcekit",
    }

    require("mason").setup()
    local mason_lspconfig = require("mason-lspconfig")
    local blink_capabilities = require("blink.cmp").get_lsp_capabilities()
    mason_lspconfig.setup({
      automatic_enable = true,
      ensure_installed = vim.tbl_filter(function(server) return server ~= "sourcekit" end, servers),
      automatic_installation = true,
    })
    for _, server_name in ipairs(servers) do
      vim.lsp.config(server_name, {
        capabilities = vim.tbl_deep_extend("force", blink_capabilities, {}),
        on_attach = on_attach,
      })
    end
    vim.lsp.enable(servers)

    -- .tmp files
    vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
      pattern = "*.tmp",
      callback = function(event)
        local original_name = vim.fn.fnamemodify(event.file, ":r")
        local filetype = vim.filetype.match({ filename = original_name })
        if filetype then
          vim.bo.filetype = filetype
        end
      end,
    })

    -- autoformatting
    local format_is_enabled = true
    vim.api.nvim_create_user_command("ToggleAutoFormat", function()
      format_is_enabled = not format_is_enabled
      print("Setting autoformatting to: " .. tostring(format_is_enabled))
    end, {})

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("lsp-attach-format", { clear = true }),
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        local bufnr = args.buf
        if not client or not client.server_capabilities.documentFormattingProvider then
          return
        end
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = vim.api.nvim_create_augroup("lsp-format-" .. client.name, { clear = true }),
          buffer = bufnr,
          callback = function()
            if not format_is_enabled then
              return
            end
            vim.lsp.buf.format({
              async = false,
              filter = function(c) return c.id == client.id end,
            })
          end,
        })
      end,
    })
  end,
}
