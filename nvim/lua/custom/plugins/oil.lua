return {
	{
		"stevearc/oil.nvim",
		opts = {},
		-- Optional dependencies
		dependencies = { { "echasnovski/mini.icons", opts = {} } },
		-- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
		view_options = {
			show_hidden = false,
			-- is_hidden_file = function(name, bufnr)
			-- 	return vim.startswith(name, ".") or vim.startswith(name, "e")
			-- end,
			-- is_always_hidden = function(name, path)
			-- 	-- Hide .o files
			-- 	if name:match("%.o$") then
			-- 		return true
			-- 	end
			-- 	return false
			-- end,
		},
	},
}
