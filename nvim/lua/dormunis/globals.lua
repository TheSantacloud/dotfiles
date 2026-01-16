P = function(v)
  print(vim.inspect(v))
  return v
end

FONT_WIDTH_HEIGHT_RATIO = 2.1

Popup = function(cmd, ratio)
  local width = vim.api.nvim_win_get_width(0)
  local height = vim.api.nvim_win_get_height(0)
  if width / (height * FONT_WIDTH_HEIGHT_RATIO) > 1 then
    if ratio then
      local split_width = math.floor(width / ratio)
      cmd = "vertical " .. split_width .. " " .. cmd
    else
      cmd = "vertical " .. cmd
    end
  end
  vim.cmd(cmd)
end

RELOAD = function(...)
  return require("plenary.reload").reload_module(...)
end

R = function(name)
  RELOAD(name)
  return require(name)
end
