return {
  {
    "metalelf0/base16-black-metal-scheme",
    config = function()
      vim.cmd.colorscheme("base16-black-metal-khold")
      vim.api.nvim_set_hl(0, 'CursorLine', { bg = '#232323' })
      vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = "#912222" })
      vim.api.nvim_set_hl(0, "TSComment", { fg = "#555555", gui = nil })
      vim.api.nvim_set_hl(0, "Comment", { fg = "#555555" })
      vim.api.nvim_set_hl(0, "Visual", { bg = "#9b8d7f", fg = "#1e1e1e" })
      vim.api.nvim_set_hl(0, "Search", { bg = "#9b8d7f", fg = "#1e1e1e" })
      vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#888888", bg = "#1e1e1e" })
      vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#888888", bg = "#1e1e1e" })
      vim.api.nvim_set_hl(0, "LineNr", { fg = "#d6d2c8" })
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
