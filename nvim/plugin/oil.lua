vim.pack.add({
  "https://github.com/echasnovski/mini.icons",
  "https://github.com/stevearc/oil.nvim",
})
require("oil").setup({
  view_options = {
    show_hidden = true,
    win_options = {
      winbar = "%{substitute(v:lua.require('oil').get_current_dir(), '^' .. vim.env.HOME, '~', '')}",
    },
    is_hidden_file = function(name, _) return false end,
    is_always_hidden = function(name, _) return name:match("%.o$") ~= nil end,
  },
})
