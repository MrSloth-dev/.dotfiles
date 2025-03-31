return {
	{
		"julianolf/nvim-dap-lldb",
		dependencies = {
			"mfussenegger/nvim-dap",
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"nvim-neotest/nvim-nio",
			"williamboman/mason.nvim",
		},
		opts = { codelldb_path = "/home/joao-pol/.var/app/io.neovim.nvim/data/nvim/mason/packages/codelldb" },

		config = function()
			local dap = require("dap")
			local ui = require("dapui")
			require("dapui").setup()

			local cfg = {
				configurations = {
					c = {
						{
							name = "Launch",
							type = "lldb",
							request = "launch",
							cwd = "${workspaceFolder}",
							program = function()
								return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
							end,
							stopOnEntry = false,
							args = {},
						},
					},
				},
			}

			require("dap-lldb").setup(cfg)
			vim.keymap.set("n", "<space>b", dap.toggle_breakpoint, { desc = "[DAP] Toggler Breakpoint" })
			vim.keymap.set("n", "<space>gb", dap.run_to_cursor, { desc = "[DAP] Run To Cursor" })

			vim.keymap.set("n", "<space>?", function()
				require("dapui").eval(nil, { enter = true })
			end)
			vim.keymap.set("n", "<F2>", dap.continue)
			vim.keymap.set("n", "<F3>", dap.step_into)
			vim.keymap.set("n", "<F4>", dap.step_over)
			vim.keymap.set("n", "<F5>", dap.step_out)
			vim.keymap.set("n", "<F6>", dap.step_back)
			vim.keymap.set("n", "<F9>", dap.restart)
			dap.listeners.before.attach.dapui_config = function()
				ui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				ui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				ui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				ui.close()
			end
		end,
	},
}
