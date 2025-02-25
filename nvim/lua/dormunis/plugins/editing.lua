return {
  {
    "preservim/vimux",
    lazy = false,
  },
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
    'saghen/blink.cmp',
    dependencies = {
      'rafamadriz/friendly-snippets',
      'echasnovski/mini.icons',
    },
    version = '*',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
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
                  local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
                  return kind_icon
                end,
                highlight = function(ctx)
                  local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                  return hl
                end,
              }
            }
          }
        }
      },
      keymap = {
        preset = 'default',
        ['<C-space>'] = {},
      },
      appearance = {
        nerd_font_variant = 'mono',
      },
      sources = {
        default = { "buffer", "lsp" },
      },
      signature = { enabled = true }
    },
    opts_extend = { "sources.default" }
  },
  {
    "zbirenbaum/copilot.lua",
    config = function()
      require("copilot").setup({
        panel = { enabled = false },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          keymap = {
            accept = "<C-space>",
            dismiss = "Esc",
          },
        },
      })
    end,
  }
}
