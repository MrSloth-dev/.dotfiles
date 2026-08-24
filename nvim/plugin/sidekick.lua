vim.pack.add({ "https://github.com/folke/sidekick.nvim" })
require("sidekick").setup({
  cli = {
    mux = {
      backend = "tmux",
      enabled = true,
    },
  },
})

local map = vim.keymap.set
map("n", "<tab>", function()
  if require("sidekick").nes_jump_or_apply() then return end
end, { expr = true, desc = "Goto/Apply Next Edit Suggestion" })
map({ "n", "t", "x" }, "`", function() require("sidekick.cli").toggle() end, { desc = "Sidekick Toggle" })
map({ "n", "x" }, "<leader>aa", function() require("sidekick.cli").toggle() end, { desc = "Sidekick Toggle CLI" })
map("n", "<leader>as", function() require("sidekick.cli").select() end, { desc = "Select CLI" })
map({ "x", "n" }, "<leader>at", function() require("sidekick.cli").send({ msg = "{this}" }) end, { desc = "Send This" })
map("n", "<leader>af", function() require("sidekick.cli").send({ msg = "{file}" }) end, { desc = "Send File" })
map("x", "<leader>av", function() require("sidekick.cli").send({ msg = "{selection}" }) end, { desc = "Send Visual Selection" })
map({ "n", "x" }, "<leader>ap", function() require("sidekick.cli").prompt() end, { desc = "Sidekick Select Prompt" })
