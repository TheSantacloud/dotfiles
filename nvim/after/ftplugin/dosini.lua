vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "platformio.ini",
  callback = function()
    vim.fn.jobstart("pio run --target compiledb", {
      on_exit = function(_, exit_code)
        if exit_code == 0 then
          for _, client in pairs(vim.lsp.get_clients({})) do
            if client.config.root_dir and vim.fn.getcwd():find(client.config.root_dir, 1, true) then
              vim.lsp.stop_client(client.id)
            end
          end
          vim.cmd("edit")
        else
          vim.notify("PlatformIO compiledb command failed.", vim.log.levels.ERROR)
        end
      end,
    })
  end,
})
