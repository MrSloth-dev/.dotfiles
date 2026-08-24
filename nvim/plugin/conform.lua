vim.pack.add({ "https://github.com/stevearc/conform.nvim" })
require("conform").setup({
  notify_on_error = false,
  formatters_by_ft = {
    lua = { "stylua" },
    c = { "clang-format" },
    cpp = { "clang-format" },
    python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
  },
  formatters = {
    ["clang-format"] = {
      args = { "--style={BasedOnStyle: Microsoft, IndentWidth: 4, UseTab: Always, ColumnLimit: 90}" },
    },
  },
})

vim.keymap.set({ "n", "x" }, "<leader>f", function()
  require("conform").format({ async = true, lsp_fallback = false })
end, { desc = "[F]ormat buffer" })
