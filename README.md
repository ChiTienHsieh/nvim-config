# nvim-config

LazyVim 基底的個人 Neovim 設定，透過 [dotfiles](https://github.com/ChiTienHsieh/dotfiles) 以 submodule 掛到 `~/.config/nvim`。

## 新機器前置需求

```bash
./scripts/bootstrap.sh
```

腳本用 Homebrew 裝 `neovim`、`node`（Mason 裝 LSP 要 npm）、`ripgrep`、`fd`、`lazygit`、`tree-sitter-cli`。
沒裝 node 的話啟動會噴 `[mason-lspconfig.nvim] failed to install ...` 和 `markdownlint-cli2: ENOENT`。

第一次開 nvim 會裝 plugin、LSP、treesitter parser，跳 `Press ENTER` 是正常的；之後用 `:checkhealth` 確認。

## 測試

```bash
nvim --clean -l tests/test_markdownlint.lua
```

細節見 `tests/README.md`。
