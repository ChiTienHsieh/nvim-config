return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters = {
        markdownlint = {
          prepend_args = {
            "--disable",
            "MD012",
            "MD013",
            "MD022",
            "MD033",
            "MD041",
          },
        },
      },
    },
  },
}
