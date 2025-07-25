local nmap = function(key, fn, desc)
  vim.keymap.set("n", key, fn, desc)
end

return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "mfussenegger/nvim-dap-python",
    "leoluz/nvim-dap-go",
    "julianolf/nvim-dap-lldb",
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "theHamsta/nvim-dap-virtual-text",
  },
  config = function()
    local dap = require("dap")
    nmap("<leader>db", function()
      dap.toggle_breakpoint()
    end, { desc = "Debug: toggle breakpoint" })

    nmap("<leader>dB", function()
      dap.set_breakpoint(vim.fn.input("Breakpoint point message: "))
    end, { desc = "Debug: conditional breakpoint" })

    nmap("<leader>dl", function()
      dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
    end, { desc = "Debug: log point" })

    nmap("<leader>dc", function()
      dap.continue()
    end, { desc = "Debug: continue" })

    nmap("<leader>do", function()
      dap.step_over()
    end, { desc = "Debug: step over" })

    nmap("<leader>di", function()
      dap.step_into()
    end, { desc = "Debug: step into" })

    nmap("<leader>dO", function()
      dap.step_out()
    end, { desc = "Debug: step out/back" })

    local dapui = require("dapui")
    dapui.setup()

    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end

    nmap("<leader><leader>d", function()
      dapui.toggle()
    end, { desc = "Debug: UI open" })

    require("nvim-dap-virtual-text").setup({
      commented = true,
    })

    -- language plugins
    local python = require("dap-python")
    -- TODO: move to uv?
    python.setup("~/.config/dap-virtualenvs/debugpy/bin/python")
    python.test_runner = "pytest"

    local dap_go = require("dap-go")
    dap_go.setup()

    local lldb_config = {
      configurations = {
        zig = {
          {
            name = "Launch debugger",
            type = "lldb",
            request = "launch",
            cwd = "${workspaceFolder}",
            program = function()
              local out = vim.fn.system({ "zig", "build", "-Doptimize=Debug" })
              if vim.v.shell_error ~= 0 then
                vim.notify(out, vim.log.levels.ERROR)
                return nil
              end

              local bin_dir = "./zig-out/bin/"
              local executable_name = nil

              for _, filename in ipairs(vim.fn.readdir(bin_dir)) do
                local filepath = bin_dir .. filename
                if vim.fn.isdirectory(filepath) == 0 then
                  executable_name = filename
                  break
                end
              end

              if not executable_name then
                vim.notify("Could not find executable in " .. bin_dir, vim.log.levels.ERROR)
                return nil
              end

              return bin_dir .. executable_name
            end,
          },
        },
      },
    }

    require("dap-lldb").setup(lldb_config)

    -- -- language keybindings
    nmap("<leader>dsl", function()
      local filetype = vim.api.nvim_get_option_value("filetype", { buf = 0 })
      if filetype == "python" then
        python.debug_selection()
      end
    end, { desc = "Debug: selection" })

    nmap("<leader>td", function()
      local filetype = vim.api.nvim_get_option_value("filetype", { buf = 0 })
      if filetype == "python" then
        -- determine if class or method (maybe using treesitter). remove <leader>tc afterwards
        python.test_method()
      elseif filetype == "go" then
        dap_go.debug_test()
      end
    end, { desc = "Debug: function" })

    nmap("<leader>tc", function()
      local filetype = vim.api.nvim_get_option_value("filetype", { buf = 0 })
      if filetype == "python" then
        python.test_class()
      end
    end, { desc = "Debug: class" })
  end,
}
