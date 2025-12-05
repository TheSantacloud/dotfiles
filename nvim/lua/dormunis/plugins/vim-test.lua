return {
  "vim-test/vim-test",
  event = "VeryLazy",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "preservim/vimux",
  },
  config = function()
    local g = vim.g
    g["test#strategy"] = "vimux"
    g["test#python#pytest#executable"] = "uv run pytest"
    g["test#python#pytest#options"] = "-s --disable-warnings"
    g["test#javascript#jest#executable"] = "npm test"
    g["test#javascript#jest#file_pattern"] = "*.test.(js|jsx|ts|tsx)"
    g["test#go#runner"] = "gotest"
    g["test#go#gotest#options"] = "-v"
    g["test#swift#runner"] = "swiftpm"
    g["test#swift#swiftpm#executable"] = "swift test"
    g["test#swift#swiftpm#options"] = "--parallel"
  end,
  keys = {
    {
      "<leader>tt",
      ":TestNearest<CR>",
      desc = "Run current test",
    },
    {
      "<leader>tl",
      ":TestLast<CR>",
      desc = "Run last test",
    },
    {
      "<leader>tf",
      ":TestFile<CR>",
      desc = "Run test file",
    },
    {
      "<leader>ts",
      ":TestSuite<CR>",
      desc = "Run test suite",
    },
    {
      "<leader>tv",
      ":TestVisit<CR>",
      desc = "Jump to last test",
    },
  },
}
