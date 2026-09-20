#!/usr/bin/env bash
# 新機器第一次用這份 nvim 設定前跑一次：裝 LazyVim / Mason 需要的外部工具。
# 缺了這些不會讓 nvim 起不來，但會在啟動時噴一堆錯誤：
#   node/npm  -> Mason 裝 pyright、vtsls、jsonls、dockerls、markdownlint-cli2 都要 npm
#   ripgrep   -> Snacks.picker grep、telescope live_grep
#   fd        -> Snacks.explorer、telescope find_files
#   lazygit   -> <leader>gg
set -euo pipefail

if ! command -v brew >/dev/null 2>&1; then
  echo "需要 Homebrew：https://brew.sh" >&2
  exit 1
fi

brew install neovim node ripgrep fd lazygit tree-sitter-cli

echo
echo "完成。第一次開 nvim 時 lazy.nvim 會裝 plugin、Mason 會裝 LSP、treesitter 會編 parser，"
echo "會多等一下並跳 'Press ENTER'，那是正常的；之後跑 :checkhealth 確認。"
