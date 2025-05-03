return {
  {
    'echasnovski/mini.nvim',
    version = "*",
    config = function()
      local statusline = require("mini.statusline")
      statusline.setup({ use_icons = true })
    end
  },
  {
    "folke/which-key.nvim",
    dependencies = { "echasnovski/mini.icons" },
    event = "VeryLazy",
    opts = {},
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
