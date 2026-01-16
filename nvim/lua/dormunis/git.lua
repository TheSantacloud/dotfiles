local function get_conflict_range()
  local cur = vim.api.nvim_win_get_cursor(0)[1]
  local start_line, sep_line, end_line, ancestor_line

  for i = cur, 1, -1 do
    local line = vim.fn.getline(i)
    if line:match("^>>>>>>>") then return nil end
    if line:match("^<<<<<<<") then start_line = i break end
  end
  if not start_line then return nil end

  for i = start_line + 1, vim.fn.line("$") do
    local line = vim.fn.getline(i)
    if line:match("^|||||||") then ancestor_line = i
    elseif line:match("^=======") then sep_line = i
    elseif line:match("^>>>>>>>") then end_line = i break end
  end
  if not sep_line or not end_line then return nil end

  return { start_line, ancestor_line or sep_line, sep_line, end_line }
end

local function resolve_conflict(keep)
  local r = get_conflict_range()
  if not r then print("Not in a conflict") return end
  local lines = {}
  if keep == "ours" or keep == "both" then
    for i = r[1] + 1, r[2] - 1 do table.insert(lines, vim.fn.getline(i)) end
  end
  if keep == "theirs" or keep == "both" then
    for i = r[3] + 1, r[4] - 1 do table.insert(lines, vim.fn.getline(i)) end
  end
  vim.api.nvim_buf_set_lines(0, r[1] - 1, r[4], false, lines)
end

vim.keymap.set("n", "<leader>co", function() resolve_conflict("ours") end, { desc = "Conflict: accept ours" })
vim.keymap.set("n", "<leader>ct", function() resolve_conflict("theirs") end, { desc = "Conflict: accept theirs" })
vim.keymap.set("n", "<leader>cb", function() resolve_conflict("both") end, { desc = "Conflict: accept both" })
