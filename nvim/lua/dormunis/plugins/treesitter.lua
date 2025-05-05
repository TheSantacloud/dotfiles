return {
  'nvim-treesitter/nvim-treesitter',
  build = ":TSUpdate",
  event = { "BufRead", "BufNewFile" },
  dependencies = {
    'nvim-treesitter/nvim-treesitter-context',
    'nvim-treesitter/nvim-treesitter-refactor',
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require('nvim-treesitter.configs').setup {
      refactor = {
        highlight_definitions = {
          enable = true,
          clear_on_cursor_move = true,
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
          }
        }
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
      ---@diagnostic disable-next-line: unused-local
      disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          return true
        end
      end,
      highlight = {
        enable = true,
      },
    }
  end
}
