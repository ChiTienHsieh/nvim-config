-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- LeetCode mode: disable all AI completion (no cheating!)
vim.g.leetcode_mode = false
vim.keymap.set("n", "<leader>lc", function()
  vim.g.leetcode_mode = not vim.g.leetcode_mode
  -- Toggle Copilot ghost text
  require("copilot.suggestion").toggle_auto_trigger()
  -- Toggle blink.cmp completion
  if vim.g.leetcode_mode then
    vim.b.completion = false  -- Disable blink for current buffer
    vim.cmd("Copilot disable")  -- Fully disable Copilot (stops blink-copilot too)
    vim.notify("LeetCode Mode ON - All AI completion disabled!", vim.log.levels.WARN)
  else
    vim.b.completion = nil  -- Re-enable blink
    vim.cmd("Copilot enable")
    vim.notify("LeetCode Mode OFF - AI completion enabled", vim.log.levels.INFO)
  end
end, { desc = "Toggle LeetCode mode (disable all AI)" })

