return {
	{
		"diogo-ss/42-header.nvim",
		cmd = { "Stdheader" },
		keys = { "<F1>" },
		opts = {
			default_map = true, -- Default mapping <F1> in normal mode.
			auto_update = true, -- Update header when saving.
			user = "joao-pol", -- Your user.
			mail = "joao-pol@student.42porto.com", -- Your mail.
			-- add other options.
		},
		config = function(_, opts)
			require("42header").setup(opts)
		end,
	},
	{
		"MrSloth-dev/42-NorminetteNvim",
		dir = "~/Projects/42-NorminetteNvim/",
		dependencies = { "nvim-lua/plenary.nvim", "echasnovski/mini.icons" },
		config = function()
			require("norminette").setup({
				keybind = "<leader>n",
				diagnost_color = "#00ff00",
				show_size = true,
			})
		end,
	},
}
