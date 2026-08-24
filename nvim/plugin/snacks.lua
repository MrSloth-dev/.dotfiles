vim.pack.add({ "https://github.com/folke/snacks.nvim" })
require("snacks").setup({
  indent = {},
  statuscolumn = {},
  picker = {
    layout = { preset = "telescope" },
    icons = {
      files = { enabled = true, dir = "󰉋 ", dir_open = "󰝰 ", file = "󰈔 " },
      keymaps = { nowait = "󰓅 " },
      tree = { vertical = "│ ", middle = "├╴", last = "└╴" },
      undo = { saved = " " },
      ui = { live = "󰐰 ", hidden = "h", ignored = "i", follow = "f", selected = "● ", unselected = "○ " },
      formatters = {
        file = {
          format = function(item, ctx)
            local text = ctx.default(item, ctx)
            if ctx.selected then return "> " .. text .. " <" end
            return "  " .. text .. "  "
          end,
        },
      },
    },
  },
})

local map = vim.keymap.set
map("n", "<leader><space>", function() Snacks.picker.buffers() end, { desc = "Buffers" })
map("n", "<leader>sn", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, { desc = "Find Config File" })
map("n", "<leader>sf", function() Snacks.picker.files() end, { desc = "Find Files" })
map("n", "<leader>sb", function() Snacks.picker.lines() end, { desc = "Buffer Lines" })
map("n", "<leader>sg", function() Snacks.picker.grep() end, { desc = "Grep" })
map({ "n", "x" }, "<leader>sw", function() Snacks.picker.grep_word() end, { desc = "Visual selection or word" })
map("n", "<leader>sk", function() Snacks.picker.keymaps() end, { desc = "Keymaps" })
map("n", "<leader>sM", function() Snacks.picker.man() end, { desc = "Man Pages" })

map("n", "<leader>su", function() Snacks.picker.undo() end, { desc = "Undo History" })
map("n", "<leader>uC", function() Snacks.picker.colorschemes() end, { desc = "Colorschemes" })
map("n", "gd", function() Snacks.picker.lsp_definitions() end, { desc = "Goto Definition" })
map("n", "gD", function() Snacks.picker.lsp_declarations() end, { desc = "Goto Declaration" })
map("n", "gr", function() Snacks.picker.lsp_references() end, { nowait = true, desc = "References" })
map("n", "gI", function() Snacks.picker.lsp_implementations() end, { desc = "Goto Implementation" })
map("n", "gy", function() Snacks.picker.lsp_type_definitions() end, { desc = "Goto T[y]pe Definition" })
map("n", "<leader>ss", function() Snacks.picker.lsp_symbols() end, { desc = "LSP Symbols" })
map("n", "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, { desc = "LSP Workspace Symbols" })
