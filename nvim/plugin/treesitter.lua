vim.pack.add({
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter",
    version = "main",
  },
})

require("nvim-treesitter").setup({
  install_dir = vim.fn.stdpath("data") .. "/site",
})

require("nvim-treesitter").install({
  "bash",
  "c",
  "comment",
  "cpp",
  "dockerfile",
  "go",
  "json",
  "lua",
  "luadoc",
  "make",
  "markdown",
  "markdown_inline",
  "python",
  "query",
  "regex",
  "rust",
  "toml",
  "vim",
  "vimdoc",
  "yaml",
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "Enable treesitter highlighting",
  callback = function()
    pcall(vim.treesitter.start)
  end,
})