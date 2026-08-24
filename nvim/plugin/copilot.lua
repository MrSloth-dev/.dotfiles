vim.api.nvim_create_autocmd("InsertEnter", {
  once = true,
  callback = function()
    vim.pack.add({
      "https://github.com/zbirenbaum/copilot.lua",
      "https://github.com/copilotlsp-nvim/copilot-lsp",
      "https://github.com/giuxtaposition/blink-cmp-copilot",
    })
    require("copilot").setup({
      suggestion = { enabled = false },
      panel = { enabled = false },
    })
    vim.lsp.enable("copilot")
  end,
})
