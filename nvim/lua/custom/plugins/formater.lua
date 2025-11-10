return {
	"tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
	{ "numToStr/Comment.nvim", opts = {} },
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},
	{ -- Autoformat
		"stevearc/conform.nvim",
		lazy = false,
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_fallback = false })
				end,
				mode = "",
				desc = "[F]ormat buffer",
			},
		},
		opts = {
			notify_on_error = false,
			--[[ format_on_save = function(bufnr)
				-- Disable "format_on_save lsp_fallback" for languages that don't
				-- have a well standardized coding style. You can add additional
				-- languages here or re-enable it for the disabled ones.
				local disable_filetypes = { c = true, cpp = true }
				return {
					timeout_ms = 500,
					lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
				}
			end, ]]
			formatters_by_ft = {
				lua = { "stylua" },
				-- Add C++ and C formatting with clang-format
				-- cpp = { "clang-format" },
				c = { "clang-format" },
				-- Ruff for Python formatting and import sorting
				python = {
					-- To fix auto-fixable lint errors.
					"ruff_fix",
					-- To run the Ruff formatter.
					"ruff_format",
					-- To organize the imports.
					"ruff_organize_imports",
				},
				--
				-- You can use a sub-list to tell conform to run *until* a formatter
				-- is found.
				-- javascript = { { "prettierd", "prettier" } },
			},
			-- Configure clang-format with custom Google style
			-- formatters = {
			-- 	["clang-format"] = {
			-- 		args = {
			-- 			"--style={BasedOnStyle: Google, BreakBeforeBraces: Allman, IndentWidth: 4, UseTab: Never, ColumnLimit: 90, AccessModifierOffset: -4}",
			-- 		},
			-- 	},
			-- },
		},
	},
}
