return {
	{
		"stevearc/oil.nvim",
		opts = {
			columns = {
				"permissions",
				"size",
				"mtime",
			},
			view_options = {
				show_hidden = true,
				win_options = {
					winbar = "%{substitute(v:lua.require('oil').get_current_dir(), '^' .. vim.env.HOME, '~', '')}",
				},
				is_hidden_file = function(name, _)
					return false
				end,
				is_always_hidden = function(name, _)
					-- Optional: Hide specific files like object files
					return name:match("%.o$") ~= nil
				end,
			},
		},
		dependencies = { { "echasnovski/mini.icons", opts = {} } },
	}
}
