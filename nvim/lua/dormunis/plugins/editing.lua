return {
  {
    "preservim/vimux",
    lazy = false,
  },
  {
    "folke/lazydev.nvim",
    event = "VeryLazy",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end,
  },
  {
    "mbbill/undotree",
    config = function()
      vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Undo Tree" })
    end,
  },
  {
    "saghen/blink.cmp",
    event = "VeryLazy",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "echasnovski/mini.icons",
    },
    version = "*",
    ---@module 'blink.cmp'
    opts = {
      completion = {
        list = {
          selection = {
            preselect = true,
            auto_insert = false,
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 500,
        },
        menu = {
          draw = {
            components = {
              kind_icon = {
                ellipsis = false,
                text = function(ctx)
                  local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
                  return kind_icon
                end,
                highlight = function(ctx)
                  local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                  return hl
                end,
              },
            },
          },
        },
      },
      keymap = {
        preset = "default",
        ["<C-space>"] = {},
      },
      appearance = {
        nerd_font_variant = "mono",
      },
      sources = {
        default = { "snippets", "lsp", "lazydev", "path", "buffer" },
        providers = {
          lazydev = {
            name = "lazydev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
        },
      },
      signature = { enabled = true },
    },
    opts_extend = { "sources.default" },
  },
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "ruff_format" },
        javascript = { "prettierd" },
        typescript = { "prettierd" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    },
  },
  {

    "supermaven-inc/supermaven-nvim",
    config = function()
      require("supermaven-nvim").setup({
        keymaps = {
          accept_suggestion = "<C-space>",
          clear_suggestion = "Esc",
          accept_word = "<C-shift-space>",
        },
      })
    end,
  },
}
