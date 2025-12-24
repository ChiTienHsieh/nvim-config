-- Notification settings via snacks.nvim (LazyVim's notification handler)
return {
  "folke/snacks.nvim",
  opts = {
    notifier = {
      timeout = 10000, -- 10 seconds
      width = { min = 40, max = 80 },
      style = "compact", -- simpler style
      icons = {
        error = "",
        warn = "",
        info = "",
        debug = "",
        trace = "",
      },
    },
  },
}
