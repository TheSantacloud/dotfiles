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
          auto_show = false,
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
        ['<Tab>'] = {},
        ['<C-i>'] = { function(cmp)
          if cmp.is_visible() then
            cmp.cancel({})
            cmp.hide({})
          else
            cmp.show({ providers = { 'lsp', 'path', 'snippets', 'buffer' } })
          end
        end },
        ['<C-n>'] = { function(cmp)
          vim.schedule(function() require('blink.cmp.completion.list').select_next({ auto_insert = true }) end)
        end },
        ['<C-p>'] = { function(cmp)
          vim.schedule(function() require('blink.cmp.completion.list').select_prev({ auto_insert = true }) end)
        end },
      },
      appearance = {
        nerd_font_variant = 'mono',
      },
      sources = {
        default = { "buffer", "lsp" },
        cmdline = {},
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
