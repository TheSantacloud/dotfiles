return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  lazy = false,
  dependencies = {
    "nvim-treesitter/nvim-treesitter-context",
    { "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" },
  },
  config = function()
    local ts = require("nvim-treesitter")
    ts.install({
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
    })

    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        if not pcall(vim.treesitter.start, args.buf) then return end
      end,
    })

    require("nvim-treesitter-textobjects").setup({
      select = { lookahead = true }
    })

    local select = require("nvim-treesitter-textobjects.select")
    vim.keymap.set({"x", "o"}, "af", function() select.select_textobject("@function.outer") end)
    vim.keymap.set({"x", "o"}, "if", function() select.select_textobject("@function.inner") end)
    vim.keymap.set({"x", "o"}, "ac", function() select.select_textobject("@class.inner") end)
    vim.keymap.set({"x", "o"}, "ic", function() select.select_textobject("@class.outer") end)

    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        local max_filesize = 100 * 1024 -- 100 KB
        local size = vim.fn.getfsize(vim.api.nvim_buf_get_name(args.buf))
        if size > max_filesize then
          vim.treesitter.stop(args.buf)
        end
      end,
    })
  end,
}
