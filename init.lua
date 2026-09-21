-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.api.nvim_create_autocmd("VimLeave", {
  callback = function()
    os.execute("clear")
  end,
})

vim.api.nvim_set_keymap("n", "Y", "y$", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", ";", "I# <ESC>0", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "'", "I<ESC>xx", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<Space>", "i <ESC>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "jk", "<ESC>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "kj", "<ESC>", { noremap = true, silent = true })

-- 關掉 remote plugin provider：這份設定沒有任何 plugin 走 pynvim / node-host / perl / ruby，
-- 開著只會讓 :checkhealth 因為沒裝 pynvim 等模組而報錯（之前用 `which python` 偵測 conda，
-- 在非互動 shell 裡拿到空字串，provider 直接壞掉）。<F11> 跑 python 走 terminal，不受影響。
vim.g.loaded_python3_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

vim.opt.spell = false
vim.opt.wrap = true       -- 長行自動換行顯示
vim.opt.linebreak = true  -- 在單字邊界換行，不切斷單字

vim.api.nvim_create_autocmd("VimEnter", {
  pattern = "*", -- 針對所有檔案觸發
  callback = function()
    vim.opt.spell = false -- 關閉拼字檢查
    vim.cmd("doautocmd User SpellDisable") -- 有些外掛可能需要這個來更新狀態
  end,
  once = true, -- 這個 autocmd 只需要在 Neovim 啟動時執行一次
})

-- Run python file with F11 (opens in terminal buffer at bottom)
vim.api.nvim_set_keymap("n", "<F11>", ":w<CR>:botright split | term python3 %<CR>", { noremap = true, silent = false })
