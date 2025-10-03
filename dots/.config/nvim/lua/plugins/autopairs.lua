return {
  {
    -- Autopairs
    "windwp/nvim-autopairs",
    events = "InsertEnter",
    opts = {},
  },
  {
    "windwp/nvim-ts-autotag",
    event = { "InsertEnter", "BufReadPost" },
    ft = { "html", "htmldjango", "xml", "javascriptreact", "typescriptreact", "svelte", "vue", "php", "razor" },
    config = function()
      require("nvim-ts-autotag").setup({
        filetypes = {
          "html",
          "htmldjango",
          "xml",
          "javascriptreact",
          "typescriptreact",
          "svelte",
          "vue",
          "php",
          "razor",
        },
        skip_tags = {
          "area",
          "base",
          "br",
          "col",
          "embed",
          "hr",
          "img",
          "input",
          "link",
          "meta",
          "param",
          "source",
          "track",
          "wbr",
        },
      })
    end,
  },
}
