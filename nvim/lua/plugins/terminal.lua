return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		opts = {
			size = 15,
			open_mapping = [[<leader>t]],
			direction = "horizontal",
			shade_terminals = false, -- Disable shading to use theme colors
			persist_size = true,
			close_on_exit = true,
			shell = vim.o.shell,
		},
		keys = {
			{ "<leader>t", "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal" },
		},
	},
}
