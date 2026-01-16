local util = require("dormunis.util")

local function find_project_root()
  return util.find_project_root({ "go.mod", "go.sum", ".git" })
end

--- Executes a Go snippet by wrapping it in a temporary main package
--- @param code string Code snippet to execute
local function execute_go_snippet(code)
  -- Wrap the code in a minimal main package
  local wrapped_code = string.format(
    [[
package main

import (
	"fmt"
)

func main() {
%s
}
]],
    code
  )

  -- Create a temporary file
  local tmpfile = vim.fn.tempname() .. ".go"
  local f = io.open(tmpfile, "w")
  if f then
    f:write(wrapped_code)
    f:close()

    -- Run the temporary file
    local output = vim.fn.system({ "go", "run", tmpfile })

    -- Clean up
    vim.fn.delete(tmpfile)

    if vim.v.shell_error == 0 then
      vim.api.nvim_echo({ { output, "Normal" } }, false, {})
    else
      vim.api.nvim_echo({ { "Error: " .. output, "ErrorMsg" } }, false, {})
    end
  else
    vim.api.nvim_echo({ { "Error: Could not create temporary file", "ErrorMsg" } }, false, {})
  end
end

--- Runs a Go file or package
--- @param path string File path to run
local function run_go_file(path)
  vim.cmd('VimuxRunCommand "go run ' .. path .. '"')
end

--- Runs go mod tidy
local function tidy_modules()
  local project_root = find_project_root()
  vim.cmd('VimuxRunCommand "cd ' .. project_root .. ' && go mod tidy"')
end

-- Keymap: Run current file
vim.keymap.set("n", "<space><space>r", function()
  local filepath = vim.fn.expand("%:p")
  run_go_file(filepath)
end, { buffer = true, desc = "Run Go file" })

-- Keymap: Run selected code
vim.keymap.set("v", "<space><space>r", function()
  local code = util.get_selected_code()
  execute_go_snippet(code)
end, { buffer = true, desc = "Run Go snippet" })

-- Keymap: Tidy modules
vim.keymap.set("n", "<space><space>s", function()
  tidy_modules()
end, { buffer = true, desc = "Run go mod tidy" })
