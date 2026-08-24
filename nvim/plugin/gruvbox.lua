vim.pack.add({ "https://github.com/ellisonleao/gruvbox.nvim" })
require("gruvbox").setup({
  terminal_colors = true,
  bold = true,
  strikethrough = true,
  invert_selection = true,
  inverse = true,
  contrast = "soft",
  overrides = {
    Pmenu = { link = "Normal" },
    TelescopeSelection = { bg = "#504945", fg = "#ebdbb2", bold = true },
    TelescopeSelectionCaret = { bg = "#504945", fg = "#fe8019", bold = true },
    SnacksPickerListCursorLine = { bg = "#504945", fg = "#ebdbb2", bold = true },
    SnacksPickerMatch = { fg = "#fe8019", bold = true },
  },
  dim_inactive = true,
  transparent_mode = false,
})
vim.cmd.colorscheme("gruvbox")
