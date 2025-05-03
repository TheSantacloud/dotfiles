local M = {}

function M.setup()
  vim.diagnostic.config({
    title = false,
    underline = true,
    virtual_text = true,
    signs = true,
    update_in_insert = false,
    severity_sort = true,
  })

  vim.keymap.set("n", "]x", function()
    vim.diagnostic.jump({ count = 1, float = true })
  end, { desc = "Next diagnostic" })

  vim.keymap.set("n", "[x", function()
    vim.diagnostic.jump({ count = -1, float = true })
  end, { desc = "Previous diagnostic" })

  vim.keymap.set("n", "X", vim.diagnostic.open_float, { desc = "Line diagnostic" })
  vim.keymap.set("n", "<leader>xx", vim.diagnostic.setloclist, { desc = "Buffer diagnostics" })
  vim.keymap.set("n", "<leader>xw", vim.diagnostic.setqflist, { desc = "Workspace diagnostics" })
end

return M
