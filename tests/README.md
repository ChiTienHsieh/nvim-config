# Neovim 回歸測試

這個測試確認 Markdown 規則經由 `opts` 合併，保留 LazyVim 的 `nvim-lint` 初始化、檔案類型對應與儲存時檢查。

在 repo 根目錄執行：

```bash
nvim --clean -l tests/test_markdownlint.lua
```

也能從其他目錄用測試檔的絕對路徑執行。測試依檔案位置定位 repo，隔離 `HOME`、`TMPDIR` 與 XDG 目錄；exit code `0` 表示通過。

固定測試來源是 [LazyVim 的 linting.lua](https://github.com/LazyVim/LazyVim/blob/28db03f958d58dfff3c647ce28fdc1cb88ac158d/lua/lazyvim/plugins/linting.lua)，commit 為 `28db03f958d58dfff3c647ce28fdc1cb88ac158d`。`tests/fixtures/lazyvim-linting.lua` 保留該來源的初始化程式碼，授權為 Apache-2.0，全文見 repo 根目錄的 `LICENSE`。

更新固定版本時，從對應上游來源重取 fixture；不要手寫假的初始化函式取代它。
