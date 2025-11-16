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
      javascript = { "prettierd", "prettier" },
      typescript = { "prettierd", "prettier" },
      nix = { "alejandra" },
      java = { "google-java-format" },
      latex = { "tex-fmt" },
      html = { "prettier" },
      css = { "prettier" },
      scss = { "prettier" },
      json = { "prettier" },
      yaml = { "prettier" },
      toml = { "prettier" },
      markdown = { "prettier" },
      -- php = { "pint" },
      php = { "php_cs_fixer" },
      qml = { "qmlformat" },
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
      -- html, css, js/ts, json, yaml, toml
      prettier = {
        append_args = function(self, ctx)
          local ft = vim.bo[ctx.buf].filetype
          if ft == "json" or ft == "yaml" or ft == "toml" then
            return { "--tab-width", "2" }
          else
            return { "--tab-width", "4" }
          end
        end,
      },
      prettierd = {
        append_args = function(self, ctx)
          local ft = vim.bo[ctx.buf].filetype
          if ft == "json" or ft == "yaml" or ft == "toml" then
            return { "--tab-width", "2" }
          else
            return { "--tab-width", "4" }
          end
        end,
      },
      -- latex
      texfmt = {},
      -- php
      -- pint = {},
      -- prettyphp = {},
      phpcsfixer = {},
      -- qml
      qmlformat = {
        command = "qmlformat",
        args = { "-i", "$FILENAME" },
        stdin = false,
      },
    },
  },
}
