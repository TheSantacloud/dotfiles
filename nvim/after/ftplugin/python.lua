--- Gets the selected code
--- @return string "Code Snippet"
local function get_selected_code()
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")
  local lines = vim.fn.getline(start_line, end_line)
  if type(selected_lines) == "string" then
    selected_lines = { selected_lines }
  end
  return table.concat(lines, "\n")
end

--- Gets the relevant python binary path (also considering virtual environments)
--- @return string "Python binary path"
local function get_python_bin()
  local virtual_env = os.getenv("VIRTUAL_ENV")
  local python_bin = "python"
  if virtual_env ~= nil and string.find(virtual_env, "poetry") then
    python_bin = virtual_env .. "/bin/python"
  end
  return python_bin
end

--- Executes a python snippet to messages within a specified binary
--- @param code string Code
--- @param opts table|nil Options table (optional). Must include `bin` (string) and `echo` (boolean).
local function execute_python_snippet(code, opts)
  opts = opts or {}
  local bin = opts.bin or "python"
  local echo = opts.echo or true

  local output = vim.fn.system({ bin, '-c', code })
  if vim.v.shell_error == 0 and echo then
    vim.api.nvim_echo({ { output, "Normal" } }, false, {})
  else
    vim.api.nvim_echo({ { "Error: " .. output, "ErrorMsg" } }, false, {})
  end
end

local function run_python_file(path)
  local cmd = 'VimuxRunCommand "poetry run python ' .. path .. '"'
  if vim.fn.executable("poetry") ~= 1 or
      vim.loop.fs_stat(vim.loop.cwd() .. "/" .. "poetry.lock") == nil then
    cmd = 'VimuxRunCommand "python ' .. path .. '"'
  end
  vim.cmd('VimuxRunCommand "poetry run python ' .. path .. '"')
end

local function activate_poetry_shell(path)
  if vim.fn.executable("poetry") ~= 1 or
      vim.loop.fs_stat(vim.loop.cwd() .. "/" .. "poetry.lock") == nil then
    return
  end
  vim.cmd('VimuxRunCommand "$(poetry env activate)"')
end

vim.keymap.set('n', '<space><space>r', function()
  local filepath = vim.fn.expand('%:p')
  run_python_file(filepath)
end)

vim.keymap.set('v', '<space><space>r', function()
  local code = get_selected_code()
  local python_bin = get_python_bin()
  execute_python_snippet(code, { bin = python_bin })
end)

vim.keymap.set('n', '<space><space>s', function()
  local filepath = vim.fn.expand('%:p')
  activate_poetry_shell(filepath)
end)
