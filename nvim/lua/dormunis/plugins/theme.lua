return {
  {
    "fenetikm/falcon",
    config = function()
      vim.g.falcon_background = 0
      vim.cmd.colorscheme("falcon")
      vim.api.nvim_set_hl(0, "CursorLine", { bg = "#232323" })
      vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = "#912222" })
    end,
  },
}
