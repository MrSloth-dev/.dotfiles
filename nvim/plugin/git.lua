vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" })
require("gitsigns").setup({
  signs = {
    add = { text = "+" },
    change = { text = "~" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
  },
})

vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/kdheepak/lazygit.nvim",
})
vim.keymap.set("n", "<leader>lg", "<cmd>LazyGit<cr>", { desc = "LazyGit" })

vim.pack.add({ "https://github.com/f-person/git-blame.nvim" })
require("gitblame").setup({
  enabled = false,
  message_template = " <summary> • <date> • <author>",
  date_format = "%Y-%m-%d %H:%M:%S",
  virtual_text_column = 1,
})
