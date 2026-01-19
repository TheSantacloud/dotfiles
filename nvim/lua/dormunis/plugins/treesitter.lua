return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufRead", "BufNewFile" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter-context",
    "nvim-treesitter/nvim-treesitter-refactor",
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  config = function()
    require("nvim-treesitter.configs").setup({
      highlight = {
        enable = true,
      },
      modules = {},
      ignore_install = {},
      refactor = {
        highlight_definitions = {
          enable = true,
          clear_on_cursor_move = true,
        },
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<CR>",
          node_incremental = "<CR>",
          node_decremental = "<BS>",
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
          },
        },
      },
      ensure_installed = {
        "c",
        "lua",
        "go",
        "vim",
        "query",
        "python",
        "javascript",
        "typescript",
        "rust",
        "terraform",
        "hcl",
        "arduino",
        "cpp",
        "css",
        "dockerfile",
        "html",
        "json",
        "make",
        "regex",
        "scala",
        "toml",
        "java",
        "sql",
        "bash",
        "yaml",
        "markdown_inline",
        "zig",
      },
      sync_install = false,
      auto_install = true,
      disable = function(_, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local size = vim.fn.getfsize(vim.api.nvim_buf_get_name(buf))
        return size > max_filesize
      end,
    })
  end,
}
