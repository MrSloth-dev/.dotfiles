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
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("norminette").setup({
				auto_run = false,
				keybind = "<leader>n",
			})
		end,
	},
}
