return {
  {
    "metalelf0/black-metal-theme-neovim",
    lazy = false,
    priority = 1000,
    config = function()
      require("black-metal").setup({
        theme = "bathory",
        variant = "dark",
      })
      require("black-metal").load()
    end,
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
