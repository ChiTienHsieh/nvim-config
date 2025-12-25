-- Notification settings via snacks.nvim (LazyVim's notification handler)
return {
  "folke/snacks.nvim",
  opts = {
    notifier = {
      timeout = 2000, -- 2 seconds (use <leader>nt to see history)
      width = { min = 40, max = 80 },
      style = "fancy", -- pretty gradients and animations
      -- Using default icons (removed custom ones that caused rendering issues)
    },
    styles = {
      notification = {
        wo = {
          winblend = 0, -- fully opaque (prevents background text bleeding through)
        },
      },
    },
  },
}
