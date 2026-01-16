local M = {}

function M.find_project_root(markers)
  local path = vim.fn.expand("%:p:h")
  while path ~= "/" do
    for _, marker in ipairs(markers) do
      if vim.loop.fs_stat(path .. "/" .. marker) then
        return path
      end
    end
    path = vim.fn.fnamemodify(path, ":h")
  end
  return vim.loop.cwd()
end

function M.get_selected_code()
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")
  local lines = vim.fn.getline(start_line, end_line)
  if type(lines) == "string" then
    lines = { lines }
  end
  return table.concat(lines, "\n")
end

return M
