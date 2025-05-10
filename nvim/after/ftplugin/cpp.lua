vim.bo.shiftwidth = 2
vim.bo.commentstring = "// %s"

local project_root = vim.fn.getcwd()
local pio_file = project_root .. "/platformio.ini"

---@param name string
---@return boolean
local file_exists = function(name)
  local f = io.open(name, "r")
  if f ~= nil then
    io.close(f)
    return true
  else
    return false
  end
end

---@class PlatformIOEnvConfig
---@field upload_speed string|nil
---@field monitor_speed string|nil
---@field upload_port string|nil

---@class PlatformIOConfig
---@field envs table<string, PlatformIOEnvConfig>

---@param filepath string platformio.ini file
---@return PlatformIOConfig|nil Parsed
local function parse_platformio_ini(filepath)
  ---@type PlatformIOConfig
  local config = { envs = {} }
  local current_env = nil

  local file = io.open(filepath, "r")
  if not file then
    print("Could not open platformio.ini")
    return nil
  end

  -- NOTE: relevant keys for the config for my purposes for now
  local relevant_keys = {
    upload_speed = true,
    monitor_speed = true,
    upload_port = true,
  }

  for line in file:lines() do
    local env_name = line:match("^%[env:(.+)%]$")
    if env_name then
      current_env = env_name
      config.envs[current_env] = {}
    elseif current_env then
      local key, value = line:match("^(%S+)%s*=%s*(.+)$")
      if key and value and relevant_keys[key] then
        config.envs[current_env][key] = value
      end
    end
  end

  file:close()
  return config
end

---@param config table<string,PlatformIOEnvConfig>|nil
local upload = function(config)
  --TODO: if multiple envs exists, open a window to pick and choose which env to run for
  local command = "pio run --target upload"
  if config ~= nil and config.envs ~= nil then
    for env, _ in pairs(config.envs) do
      command = command .. " --environment " .. env
      break
    end
  end
  vim.cmd('VimuxRunCommand "' .. command .. '"')
end

---@param config PlatformIOConfig|nil
local compile = function(config)
  --TODO: if multiple envs exists, open a window to pick and choose which env to run for
  local command = "pio run"
  if config ~= nil and config.envs ~= nil then
    for env, _ in pairs(config.envs) do
      command = command .. " --environment " .. env
      break
    end
  end
  vim.cmd('VimuxRunCommand "' .. command .. '"')
end

if file_exists(pio_file) then
  local config = parse_platformio_ini(pio_file)
  vim.keymap.set("n", "<space><space>r", function()
    upload(config)
  end)
  vim.keymap.set("n", "<space><space>c", function()
    compile(config)
  end)
  vim.keymap.set("n", "<space><space>m", function()
    vim.cmd('VimuxRunCommand "pio device monitor"')
  end)

  vim.api.nvim_create_user_command("CompileDB", function()
    vim.cmd("!pio run --target compiledb")
  end, {})
end
