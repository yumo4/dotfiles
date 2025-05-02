return { -- Autoformat
  "stevearc/conform.nvim",
  opts = {
    notify_on_error = false,
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "isort", "black" },
      go = { "gofumpt", "goimports-reviser" },
      javascript = { { "prettierd", "prettier" } },
      nix = { "alejandra" },
      java = { "google-java-format" },
      latex = { "tex-fmt" },
      html = { "htmlbeautifier" },
      -- css = { "stylelint" },
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
      -- html
      htmlbeutifier = {},
      -- css
      -- stylelint = {},
      -- js
      prettierd = {},
      -- tex-fmt = {
      -- },
    },
  },
}
