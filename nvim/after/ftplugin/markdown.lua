local replace_selected_text = function()
  local start_pos = vim.fn.getpos("v")
  local end_pos = vim.fn.getpos(".")
  local candidate_text = vim.fn.getregion(start_pos, end_pos, { type = "v" })

  if #candidate_text ~= 1 then
    return
  end

  local text = candidate_text[1]
  local surrounded_text = "[[" .. text .. "]]"
  vim.fn.setreg("v", surrounded_text)
  vim.cmd('normal! d"vP')
end

vim.keymap.set("v", "<c-l>", replace_selected_text, {})
