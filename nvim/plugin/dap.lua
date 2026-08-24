vim.pack.add({
  "https://github.com/mfussenegger/nvim-dap",
  "https://github.com/nvim-neotest/nvim-nio",
  "https://github.com/rcarriga/nvim-dap-ui",
  "https://github.com/mfussenegger/nvim-dap-python",
  "https://github.com/theHamsta/nvim-dap-virtual-text",
})

local dap = require("dap")
local dapui = require("dapui")
local dap_python = require("dap-python")

require("dapui").setup({})
require("nvim-dap-virtual-text").setup({ commented = true })

dap_python.setup("~/.local/share/nvim/mason/packages/debugpy/venv/bin/python")

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "DiagnosticSignWarn", linehl = "Visual", numhl = "DiagnosticSignWarn" })

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

local sopts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>db", function() dap.toggle_breakpoint() end, sopts)
vim.keymap.set("n", "<leader>dc", function() dap.continue() end, sopts)
vim.keymap.set("n", "<leader>do", function() dap.step_over() end, sopts)
vim.keymap.set("n", "<leader>di", function() dap.step_into() end, sopts)
vim.keymap.set("n", "<leader>dO", function() dap.step_out() end, sopts)
vim.keymap.set("n", "<leader>dq", function() require("dap").terminate() end, sopts)
vim.keymap.set("n", "<leader>du", function() dapui.toggle() end, sopts)
