return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		opts = {
			size = 15,
			open_mapping = [[<leader>t]],
			-- direction = "floating",
			shade_terminals = false, -- Disable shading to use theme colors
			persist_size = true,
			close_on_exit = true,
			shell = vim.o.shell,
		},
		keys = {
			{
				"<leader>tb",
				function()
					local Terminal = require("toggleterm.terminal").Terminal

					-- Check if buffer terminal exists and is open
					if _G.buffer_term and _G.buffer_term:is_open() then
						_G.buffer_term:shutdown()
						_G.buffer_term = nil
						return
					end

					-- Create new terminal in buffer's directory
					_G.buffer_term = Terminal:new({
						dir = vim.fn.expand("%:p:h"),
						direction = "float",
						close_on_exit = true,
						on_close = function()
							if _G.buffer_term then
								_G.buffer_term:shutdown()
								_G.buffer_term = nil
							end
						end,
					})

					_G.buffer_term:toggle()
				end,
				desc = "Toggle Terminal (buffer dir)",
			},
		},
	},
}
