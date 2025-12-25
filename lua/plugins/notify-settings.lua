-- Notification settings via snacks.nvim (LazyVim's notification handler)
return {
  "folke/snacks.nvim",
  opts = {
    notifier = {
      timeout = 10000, -- 10 seconds
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
