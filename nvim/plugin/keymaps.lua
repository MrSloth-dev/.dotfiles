-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

--Custom Keymaps---
vim.keymap.set("v", "<A-j>", ":m +1 '> +1<CR>gv=gv", { desc = "Swap selection with line below" })
vim.keymap.set("v", "<A-k>", ":m -2 '< -2<CR>gv=gv", { desc = "Swap selection with line above" })
vim.keymap.set("n", "<A-k>", ":m -2 <CR>", { desc = "Swap with line above" })
vim.keymap.set("n", "<A-j>", ":m +1 <CR>", { desc = "Swap with line below" })
vim.keymap.set("i", "kj", "<Esc>", { desc = "Exit to Normal Mode" })
vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit to Normal Mode" })
vim.keymap.set("n", "j", "gj", { desc = "Move Down", silent = true })
vim.keymap.set("n", "k", "gk", { desc = "Move Up", silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Move UP" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Move DOWN" })

vim.keymap.set("n", "-", ":Oil <CR>", { silent = true, desc = "Open Oil" })
vim.keymap.set("n", "<leader>gb", ":GitBlameToggle<CR>", { desc = "Git Blame Toggle" })
vim.keymap.set("n", "<Leader>nf", ":lua require('neogen').generate()<CR>", { desc = "Neogen" })
vim.keymap.set("n", "<Leader>j", "zo", { desc = "fold open" })
vim.keymap.set("n", "<Leader>k", "zc", { desc = "fold close" })
-- vim.keymap.set("n", "<Leader>csv", ":CsvViewToggle display_mode=border header_lnum=1 | lua vim.opt_local.wrap:toggle()<CR>", { desc = "Toggle CSV Viewer and line wrap" })
vim.keymap.set("n", "<Leader>csv", function()
  -- Execute the plugin's toggle command
vim.cmd("CsvViewToggle display_mode=border header_lnum=1")

  -- Toggle the line wrap setting for the current window only.
  -- This is the Lua equivalent of `:setlocal wrap!`
  vim.opt_local.wrap = not vim.opt_local.wrap
end, { desc = "Toggle CSV Viewer and line wrap" })

vim.env.PATH = vim.env.PATH .. ":/home/joao-pol/.local/share/homebrew/bin"
vim.env.PATH = vim.env.PATH .. ":/snap/bin/"
-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
-- vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
-- vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
-- vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
-- Open compiler
vim.api.nvim_set_keymap('n', '<F6>', "<cmd>CompilerOpen<cr>", { noremap = true, silent = true })

-- Redo last selected option
vim.api.nvim_set_keymap('n', '<S-F6>',
  "<cmd>CompilerStop<cr>" -- (Optional, to dispose all tasks before redo)
  .. "<cmd>CompilerRedo<cr>",
  { noremap = true, silent = true })

-- Toggle compiler results
vim.api.nvim_set_keymap('n', '<S-F7>', "<cmd>CompilerToggleResults<cr>", { noremap = true, silent = true })
