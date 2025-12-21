-- Override LazyVim's copilot config to use inline suggestions (ghost text)
return {
  -- Disable copilot-cmp integration (we want ghost text, not completion menu)
  { "zbirenbaum/copilot-cmp", enabled = false },

  -- Configure copilot.lua for inline suggestions
  {
    "zbirenbaum/copilot.lua",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,  -- Show suggestions automatically as you type
        keymap = {
          accept = false,  -- We handle this in keymaps.lua
          accept_word = "<C-Right>",  -- Ctrl+Right to accept word
          accept_line = "<C-e>",      -- Ctrl+e to accept line (e = end)
          next = "<C-n>",             -- Ctrl+n for next suggestion
          prev = "<C-p>",             -- Ctrl+p for previous suggestion
          dismiss = "<C-c>",          -- Ctrl+c to dismiss
        },
      },
      panel = { enabled = false },  -- Disable the side panel
    },
  },
}
