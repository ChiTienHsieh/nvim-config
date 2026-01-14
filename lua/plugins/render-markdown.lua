-- Beautiful markdown rendering in Neovim
-- Makes headers, tables, code blocks, and checkboxes look pretty
return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter", -- Required for parsing
    "nvim-tree/nvim-web-devicons", -- Optional: for file icons
  },
  ft = { "markdown" }, -- Only load for markdown files
  opts = {
    -- Render mode: 'rendered' shows pretty version, 'raw' shows source
    render_modes = { "n", "c" }, -- Render in normal and command mode
    -- Headers get nice icons and background colors
    heading = {
      enabled = true,
      icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " }, -- H1-H6 icons
      width = "block", -- Only highlight the text, not full line
    },
    -- Code blocks get background highlighting
    code = {
      enabled = true,
      sign = false, -- No sign column indicator
      style = "full", -- Full background for code blocks
    },
    -- Tables look like actual tables
    pipe_table = {
      enabled = true,
      style = "full", -- Full borders
    },
    -- Checkboxes become pretty icons
    checkbox = {
      enabled = true,
      unchecked = { icon = "󰄱 " },
      checked = { icon = "󰄵 " },
    },
  },
}
