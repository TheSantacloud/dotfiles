--- Find project root by looking for common project markers
--- @return string "Project root path"
local function find_project_root()
  local markers = { "pyproject.toml", "poetry.lock", ".git", "requirements.txt", ".venv" }
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

--- Gets the selected code
--- @return string "Code Snippet"
local function get_selected_code()
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")
  local lines = vim.fn.getline(start_line, end_line)
  if type(lines) == "string" then
    lines = { lines }
  end
  return table.concat(lines, "\n")
end

local function get_python_bin()
  local project_root = find_project_root()

  for _, python_name in ipairs({ "python3", "python" }) do
    local venv_python = project_root .. "/.venv/bin/" .. python_name
    if vim.loop.fs_stat(venv_python) then
      return venv_python
    end
  end

  if vim.fn.executable("poetry") == 1 and vim.loop.fs_stat(project_root .. "/poetry.lock") then
    return "poetry run python"
  end

  return "python"
end

--- Executes a python snippet to messages within a specified binary
--- @param code string Code
--- @param opts table|nil Options table (optional). Must include `bin` (string) and `echo` (boolean).
local function execute_python_snippet(code, opts)
  opts = opts or {}
  local bin = opts.bin or "python"
  local echo = opts.echo or true

  local output = vim.fn.system({ bin, "-c", code })
  if vim.v.shell_error == 0 and echo then
    vim.api.nvim_echo({ { output, "Normal" } }, false, {})
  else
    vim.api.nvim_echo({ { "Error: " .. output, "ErrorMsg" } }, false, {})
  end
end

local function run_python_file(path)
  local python_bin = get_python_bin()
  vim.cmd('VimuxRunCommand "' .. python_bin .. " " .. path .. '"')
end

local function activate_virtual_env()
  local project_root = find_project_root()

  -- First try local .venv
  if vim.loop.fs_stat(project_root .. "/.venv/bin/activate") then
    vim.cmd('VimuxRunCommand "source ' .. project_root .. '/.venv/bin/activate"')
    return
  end

  -- Fall back to poetry
  if vim.fn.executable("poetry") == 1 and vim.loop.fs_stat(project_root .. "/poetry.lock") then
    vim.cmd('VimuxRunCommand "$(poetry env activate)"')
    return
  end

  vim.api.nvim_echo({ { "No virtual environment found", "WarningMsg" } }, false, {})
end

vim.keymap.set("n", "<space><space>r", function()
  local filepath = vim.fn.expand("%:p")
  run_python_file(filepath)
end)

vim.keymap.set("v", "<space><space>r", function()
  local code = get_selected_code()
  local python_bin = get_python_bin()
  execute_python_snippet(code, { bin = python_bin })
end)

vim.keymap.set("n", "<space><space>s", function()
  activate_virtual_env()
end)
