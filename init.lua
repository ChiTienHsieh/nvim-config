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

vim.cmd([[
call plug#begin('~/.local/share/nvim/plugged')
Plug 'github/copilot.vim'
call plug#end()
]])

local function get_conda_python()
  local handle = io.popen("which python")
  if handle then
    local python_path = handle:read("*a"):gsub("\n", "")
    handle:close()
    return python_path
  end
  return "/usr/bin/python3" -- Fallback if Conda is not active
end

vim.g.python3_host_prog = get_conda_python()

vim.opt.spell = false

vim.api.nvim_create_autocmd("VimEnter", {
  pattern = "*", -- 針對所有檔案觸發
  callback = function()
    vim.opt.spell = false -- 關閉拼字檢查
    vim.cmd("doautocmd User SpellDisable") -- 有些外掛可能需要這個來更新狀態
  end,
  once = true, -- 這個 autocmd 只需要在 Neovim 啟動時執行一次
})
