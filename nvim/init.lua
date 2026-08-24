vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = true
vim.g.loaded_treesitter = false

vim.loader.enable()

local old_notify = vim.notify
function vim.notify(msg, level)
  if msg:find("WARNING: vim.treesitter.get_parser") then
    return
  end
  old_notify(msg, level)
end

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
