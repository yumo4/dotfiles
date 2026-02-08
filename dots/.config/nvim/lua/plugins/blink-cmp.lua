return {
  "saghen/blink.cmp",
  dependencies = {
    {
      "L3MON4D3/LuaSnip",
      version = "2.*",
      build = (function()
        -- Build Step is needed for regex support in snippets.
        -- This step is not supported in many windows environments.
        -- Remove the below condition to re-enable on windows.
        if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
          return
        end
        return "make install_jsregexp"
      end)(),
      dependencies = {
        -- `friendly-snippets` contains a variety of premade snippets.
        {
          "rafamadriz/friendly-snippets",
          config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
          end,
        },
      },
      opts = {},
    },
    "folke/lazydev.nvim",
    -- Copilot core
    {
      "zbirenbaum/copilot.lua",
      cmd = "Copilot",
      event = "InsertEnter",
      opts = {
        suggestion = { enabled = false }, -- disable inline ghost text
        panel = { enabled = false }, -- disable panel UI
      },
    },

    -- Copilot as a completion source (nvim-cmp source)
    {
      "zbirenbaum/copilot-cmp",
      dependencies = { "zbirenbaum/copilot.lua" },
      config = function()
        require("copilot_cmp").setup()
      end,
    },

    -- Bridge nvim-cmp sources into blink
    {
      "saghen/blink.compat",
      version = "*",
      opts = {},
    },
  },

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
      default = { "copilot", "lazydev", "lsp", "path", "snippets", "buffer" },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },
        -- This is the important part:
        -- Use blink.compat to wrap the nvim-cmp "copilot" source.
        copilot = {
          name = "Copilot",
          module = "blink.compat.source",
          score_offset = 50,
          opts = {
            -- name of the nvim-cmp source to wrap:
            name = "copilot",
          },
        },
      },
    },

    signature = { enabled = true },

    fuzzy = { implementation = "prefer_rust_with_warning" },
  },
  opts_extend = { "sources.default" },
}
