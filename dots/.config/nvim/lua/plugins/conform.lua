return { -- Autoformat
  "stevearc/conform.nvim",
  opts = {
    notify_on_error = false,
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = "fallback",
    },
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "isort", "black" },
      go = { "gofumpt", "goimports-reviser" },
      javascript = { "prettierd", "prettier", stop_after_first = true },
      typescript = { "prettierd", "prettier", stop_after_first = true },
      nix = { "alejandra" },
      java = { "google-java-format" },
      latex = { "tex-fmt" },
      html = { "prettier" },
      css = { "prettier" },
      scss = { "prettier" },
      json = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      -- php = { "pint" },
      php = { "php_cs_fixer" },
    },
    formatters = {
      -- lua
      stylua = {
        prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" },
      },
      -- go
      gofumpt = {
        prepend_args = { "--indent-type", "Tabs", "--indent-width", "4" },
      },
      -- nix
      alejandra = {},
      -- java
      google_java_format = {},
      -- html css js/ts
      prettier = {
        prepend_args = { "--tab-width", "4" },
      },
      prettierd = {
        prepend_args = { "--tab-width", "4" },
      },
      -- latex
      texfmt = {},
      -- php
      -- pint = {},
      -- prettyphp = {},
      phpcsfixer = {},
    },
  },
}
