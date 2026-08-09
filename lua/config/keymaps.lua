-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- LeetCode mode: disable completion suggestions (no cheating!)
vim.g.leetcode_mode = false
vim.keymap.set("n", "<leader>lc", function()
  vim.g.leetcode_mode = not vim.g.leetcode_mode

  if vim.g.leetcode_mode then
    vim.b.completion = false -- Disable blink for current buffer
    vim.notify("LeetCode Mode ON - Completion disabled!", vim.log.levels.WARN)
  else
    vim.b.completion = nil -- Re-enable blink
    vim.notify("LeetCode Mode OFF - Completion enabled", vim.log.levels.INFO)
  end
end, { desc = "Toggle LeetCode mode (disable completion)" })

-- Notification history (for copying error messages to debug)
vim.keymap.set("n", "<leader>nt", function()
  Snacks.notifier.show_history()
end, { desc = "Notification history" })
