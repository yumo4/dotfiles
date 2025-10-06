return {
  "saghen/blink.cmp",
  dependencies = "rafamadriz/friendly-snippets",

  version = "v1.*",
  build = "nix run .#build-plugin",

  opts = {
    keymap = { preset = "default" },

    appearance = {
      -- use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
    },

    completion = { documentation = { auto_show = true } },

    sources = {
      default = { "lazydev", "lsp", "path", "snippets", "buffer" },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },
      },
    },

    signature = { enabled = true },

    fuzzy = { implementation = "prefer_rust_with_warning" },
  },
  opts_extend = { "sources.default" },
}
