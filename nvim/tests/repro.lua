vim.env.LAZY_STDPATH = ".repro"
load(vim.fn.system("curl -s https://raw.githubusercontent.com/folke/lazy.nvim/main/bootstrap.lua"))()

require("lazy.minit").repro({
	spec = {
		"stevearc/conform.nvim",
		"nvim-neotest/nvim-nio",
	},
})

-- do anything else you need to do to reproduce the issue
