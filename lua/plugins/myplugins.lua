local map = vim.keymap.set

local plugins = {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "rcarriga/nvim-dap-ui",
      "leoluz/nvim-dap-go",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      require("dap-go").setup()
      require("dapui").setup()
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
      map("n", "<Leader>db", "<cmd> DapToggleBreakpoint <CR>", { desc = "Toggle BreakPoint" })
      map("n", "<Leader>dc", "<cmd> DapContinue <CR>", { desc = "Debug Continue" })
      map("n", "<Leader>dn", "<cmd> DapStepOver <CR>", { desc = "Debug StepOver" })
      map("n", "<Leader>di", "<cmd> DapStepInto <CR>", { desc = "Debug StepInto" })
      map("n", "<Leader>do", "<cmd> DapStepOut <CR>", { desc = "Debug StepOut" })
      map("n", "<Leader>dr", "<cmd> DapToggleRepl <CR>", { desc = "Dap Toggle Repl" })
      map("n", "<Leader>dt", "<cmd> DapTerminate <CR>", { desc = "Debug Terminate" })
      map("n", "<Leader>dus", function () local dapui = require("dapui") dapui.setup() dapui.toggle() end , { desc = "Open Dap UI" })
    end
  },
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = "mfussenegger/nvim-dap",
    config = function(_, opts)
      require("dap-go").setup(opts)
      map("n", "<Leader>dgt", function() require('dap-go').debug_test() end , { desc = "Debug Go Test" })
      map("n", "<Leader>dgl", function() require('dap-go').debug_last() end , { desc = "Debug Go Last Yest" })
    end
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    config = function(_, opts)
      local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(path)
      map("n", "<Leader>dpr", function() require('dap-python').test_method() end , { desc = "Dap Python" })
    end
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    ft = {"python","go"},
    opts = function()
      return require "configs.null-ls"
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "black",
        "debugpy",
        "mypy",
        "ruff",
        "pyright",
        "gopls",
        "lua-language-server",
        "gofumpt",
        "golangci-lint"
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "nvchad.configs.lspconfig"
      require "configs.lspconfig"
    end,
  },
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    config = function(_, opts)
      require("gopher").setup(opts)
      map("n", "<Leader>gsj", "<cmd> GoTagAdd json <CR>", { desc = "Add JSON Struct Tags" })
      map("n", "<Leader>gsy","<cmd> GoTagAdd json <CR>", { desc = "Add YAML Stuct Tags" })
    end,
    build = function()
      vim.cmd [[silent! GoInstallDeps]]
    end,
  },
}
return plugins
