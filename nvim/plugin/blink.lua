vim.pack.add({
  "https://github.com/rafamadriz/friendly-snippets",
  "https://github.com/folke/lazydev.nvim",
  {
    src = "https://github.com/saghen/blink.cmp",
    version = vim.version.range("1.*"),
  },
})
require("blink.cmp").setup({
  keymap = { preset = "default" },
  completion = {
    accept = { auto_brackets = { enabled = true } },
    menu = {
      border = "rounded",
      draw = {
        columns = { { "kind_icon" }, { "label", "label_description", gap = 1 } },
      },
    },
    documentation = { auto_show = true, auto_show_delay_ms = 200, window = { border = "rounded" } },
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },
  signature = { enabled = true, window = { border = "rounded" } },
  appearance = {
    use_nvim_cmp_as_default = false,
    nerd_font_variant = "mono",
    kind_icons = {
      Text = "󰉿", Method = "󰊕", Function = "󰊕", Constructor = "󰒓",
      Field = "󰜢", Variable = "󰆦", Property = "󰖷", Class = "󱡠",
      Interface = "󱡠", Struct = "󱡠", Module = "󰅩", Unit = "󰪚",
      Value = "󰦨", Enum = "󰦨", EnumMember = "󰦨", Keyword = "󰻾",
      Constant = "󰏿", Snippet = "󱄽", Color = "󰏘", File = "󰈔",
      Reference = "󰬲", Folder = "󰉋", Event = "󱐋", Operator = "󰪚",
      TypeParameter = "󰬛",
    },
  },
})
