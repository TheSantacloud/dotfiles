return {
  {
    "git@github.com:tpope/vim-abolish.git",
  },
  {
    "git@github.com:junegunn/vim-easy-align",
    keys= {
      { "ga", "<Plug>(EasyAlign)", mode = { "n", "x" }, desc = "Easy Align"}
    }
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
    version = "*",
    ---@module 'blink.cmp'
    opts = {
      completion = {
        menu = { auto_show = false },
        list = {
          selection = {
            preselect = true,
            auto_insert = false,
          },
        },
        ghost_text = { enabled = true },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
        },
      },
      keymap = {
        preset = "none",
        ["<C-n>"] = { "show", "select_next", "fallback_to_mappings" },
        ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
        ["<C-y>"] = { "select_and_accept", "fallback" },
        ["<C-e>"] = { "cancel", "fallback" },
        ["<C-space>"] = { "accept", "fallback" },
      },
      sources = { default = { "lsp", "buffer", "path" } },
      signature = { enabled = true },
    },
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
    },
  },
  -- {
  --   "supermaven-inc/supermaven-nvim",
  --   config = function()
  --     require("supermaven-nvim").setup({
  --       keymaps = {
  --         accept_suggestion = "<C-space>",
  --         clear_suggestion = "Esc",
  --         accept_word = "<C-shift-space>",
  --       },
  --     })
  --   end,
  -- },
}
