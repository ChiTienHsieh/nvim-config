-- LeetCode + Gamification plugins
-- 讓刷題變成打遊戲！

return {
  -- leetcode.nvim: 在 Nvim 裡直接刷 LeetCode
  -- GitHub: https://github.com/kawre/leetcode.nvim (1,900+ stars)
  {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      -- optional
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      lang = "python3", -- 預設語言
      cn = { -- 使用國際版，不是中國版
        enabled = false,
      },
      storage = {
        home = vim.fn.stdpath("data") .. "/leetcode",
        cache = vim.fn.stdpath("cache") .. "/leetcode",
      },
      injector = {
        ["python3"] = {
          before = "from typing import List, Optional",
        },
      },
    },
    -- 用 :Leet 指令啟動
  },

  -- triforce.nvim: 寫 code 賺 XP、升級、成就系統
  -- GitHub: https://github.com/gisketch/triforce.nvim (~200 stars, 快速成長中)
  {
    "gisketch/triforce.nvim",
    dependencies = {
      "nvzone/volt",  -- UI framework for triforce
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("triforce").setup({
        -- 預設設定就很好用，之後可以自訂
      })
    end,
  },
}
