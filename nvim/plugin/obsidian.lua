vim.pack.add({
  {
    src = "https://github.com/obsidian-nvim/obsidian.nvim",
    version = vim.version.range("*"),
  },
})
require("obsidian").setup({
  legacy_commands = false,
  workspaces = {
    { name = "personal", path = "~/vaults/personal" },
    { name = "work", path = "/mnt/c/Users/joao.barbosa/LTP" },
  },
})
