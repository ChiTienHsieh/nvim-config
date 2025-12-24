-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Use 4 spaces for indentation (like a civilized Python developer)
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

-- Disable showing invisible characters (spaces, tabs, etc.)
vim.opt.list = false

-- Use absolute line numbers (not relative)
vim.opt.relativenumber = false

-- 關閉 inline diagnostic 顯示（那個超煩的錯誤訊息）
-- 用 autocmd 確保在 LSP 載入後才設定
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function()
    vim.diagnostic.config({
      virtual_text = false,
      signs = false,  -- 關掉左邊的 E/W signs
      underline = false,
      update_in_insert = false,
    })
  end,
})

-- 也在啟動時設一次
vim.diagnostic.config({
  virtual_text = false,
  signs = false,  -- 關掉左邊的 E/W signs
  underline = false,
  update_in_insert = false,
})
