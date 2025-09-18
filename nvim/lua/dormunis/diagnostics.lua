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
    vim.diagnostic.jump({ count = 1, float = true, severity = { min = vim.diagnostic.severity.ERROR } })
  end, { desc = "Next diagnostic" })

  vim.keymap.set("n", "[x", function()
    vim.diagnostic.jump({ count = -1, float = true, severity = { min = vim.diagnostic.severity.ERROR } })
  end, { desc = "Previous diagnostic" })

  vim.keymap.set("n", "]w", function()
    vim.diagnostic.jump({ count = 1, float = true, severity = vim.diagnostic.severity.WARN })
  end, { desc = "Next warning diagnostic" })

  vim.keymap.set("n", "[w", function()
    vim.diagnostic.jump({ count = -1, float = true, severity = vim.diagnostic.severity.WARN })
  end, { desc = "Previous warning diagnostic" })

  vim.keymap.set("n", "X", vim.diagnostic.open_float, { desc = "Line diagnostic" })
  vim.keymap.set("n", "<leader>xx", vim.diagnostic.setloclist, { desc = "Buffer diagnostics" })
  vim.keymap.set("n", "<leader>xw", vim.diagnostic.setqflist, { desc = "Workspace diagnostics" })
  vim.keymap.set("n", "<C-X>", function()
    local line = vim.api.nvim_win_get_cursor(0)[1] - 1
    local diagnostics = vim.diagnostic.get(0, { lnum = line })
    if #diagnostics == 0 then
      print("No diagnostics on this line")
      return
    end
    local messages = {}
    for _, diag in ipairs(diagnostics) do
      table.insert(messages, diag.message)
    end
    local output = table.concat(messages, "\n")
    vim.fn.setreg("+", output)
    print("Copied diagnostic message(s) to clipboard")
  end, { desc = "Copy current line diagnostics to clipboard" })
end

return M
