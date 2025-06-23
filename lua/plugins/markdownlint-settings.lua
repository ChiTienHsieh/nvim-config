return {
  {
    "mfussenegger/nvim-lint",
    config = function()
      require("lint").linters.markdownlint.args = {
        "--disable",
        "MD012",
        "MD013",
        "MD022",
        "MD033",
        "MD041",
      }
    end,
  },
}