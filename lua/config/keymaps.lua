-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- LeetCode mode: toggle Copilot auto-trigger (no cheating!)
vim.g.leetcode_mode = false
vim.keymap.set("n", "<leader>lc", function()
  vim.g.leetcode_mode = not vim.g.leetcode_mode
  require("copilot.suggestion").toggle_auto_trigger()
  if vim.g.leetcode_mode then
    vim.notify("LeetCode Mode ON - Copilot disabled, no cheating!", vim.log.levels.WARN)
  else
    vim.notify("LeetCode Mode OFF - Copilot enabled", vim.log.levels.INFO)
  end
end, { desc = "Toggle LeetCode mode (disable Copilot)" })

