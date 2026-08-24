vim.pack.add({
  {
    src = "https://github.com/akinsho/toggleterm.nvim",
    version = vim.version.range("*"),
  },
})
require("toggleterm").setup({
  size = 15,
  direction = "float",
  shade_terminals = false,
  persist_size = true,
  close_on_exit = true,
  shell = vim.o.shell,
})
