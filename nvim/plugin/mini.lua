vim.pack.add({ "https://github.com/echasnovski/mini.nvim" })

local mini_ai = require("mini.ai")
mini_ai.setup({ n_lines = 100 })

require("mini.surround").setup()

local statusline = require("mini.statusline")
statusline.setup({ use_icons = vim.g.have_nerd_font })
statusline.section_location = function()
  return "%2l:%-2v"
end
