return {
	"epwalsh/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = true,
	ft = "markdown",
	-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
	-- event = {
	--   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
	--   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
	--   -- refer to `:h file-pattern` for more examples
	--   "BufReadPre path/to/my-vault/*.md",
	--   "BufNewFile path/to/my-vault/*.md",
	-- },
	dependencies = {
		-- Required.
		"nvim-lua/plenary.nvim",

		-- see below for full list of optional dependencies 👇
	},
	opts = {
		follow_url_func = function(url)
			-- Open the URL in the default web browser.
			-- vim.fn.jobstart({ "open", url }) -- Mac OS
			-- vim.fn.jobstart({ "xdg-open", url }) -- linux
			-- vim.cmd(':silent exec "!start ' .. url .. '"') -- Windows
			vim.ui.open(url) -- need Neovim 0.10.0+
		end,
		workspaces = {
			{
				name = "Projects",
				path = "~/ObsidianNotes",
			},
			-- {
			-- 	name = "2.Areas",
			-- 	path = "~/.dotfiles/.Obsidian/2.Areas/",
			-- },
			-- {
			-- 	name = "3.Resources",
			-- 	path = "~/.dotfiles/.Obsidian/3.Resources/",
			-- },
			-- {
			-- 	name = "4.Archives",
			-- 	path = "~/.dotfiles/.Obsidian/4.Archives/",
			-- },
		},
	},
}
