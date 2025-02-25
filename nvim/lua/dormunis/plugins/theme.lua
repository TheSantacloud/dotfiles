return {
  {
    "fenetikm/falcon",
    config = function()
      vim.g.falcon_background = 0
      vim.cmd.colorscheme("falcon")
      vim.api.nvim_set_hl(0, 'CursorLine', { bg = '#232323' })
      vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = "#912222" })
    end
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    main = "ibl",
    opts = {},
    config = function()
      require("ibl").setup {
        indent = { char = "┊" },
        scope = {
          enabled = true,
          show_exact_scope = true,
          show_start = false,
          show_end = false,
          highlight = { "Function", "Label" },
        },
      }
    end
  },
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require("colorizer").setup()
    end
  }
}
