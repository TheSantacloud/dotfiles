local GIST_URL = "https://gist.githubusercontent.com/TheSantacloud/0599ce563f3ed389a5ff5b5c1388f85c/raw/build.sh"

local function exists(path)
  return vim.fn.filereadable(path) == 1 or vim.fn.isdirectory(path) == 1
end

local function get_app_bundle_name()
  local app_name = vim.fn.system(
    "swift package describe --type json | jq -r '.targets[] | select(.type == \"executable\") | .name'"):gsub("%s+$",
    "")
  return ".build/debug/dev:" .. app_name .. ".app"
end

local function build()
  if exists("Package.swift") then
    if not exists("build.sh") then
      vim.fn.system({ "curl", "-fsSL", "-o", "build.sh", GIST_URL })
      vim.fn.system({ "chmod", "+x", "build.sh" })
    end
    vim.cmd("!./build.sh")
  else
    vim.cmd("!swift build")
  end
end

local function run()
  if exists("Package.swift") then
    local app_bundle = get_app_bundle_name()
    vim.cmd("!open " .. app_bundle)
  else
    vim.cmd("!swift run")
  end
end

vim.keymap.set("n", "<space><space>b", build)
vim.keymap.set("n", "<space><space>r", run)
vim.keymap.set("v", "<space><space>r", run)
