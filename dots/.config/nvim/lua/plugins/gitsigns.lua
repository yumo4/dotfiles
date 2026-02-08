return { -- Adds git related signs to the gutter, as well as utilities for managing changes
  "lewis6991/gitsigns.nvim",
  opts = {
    signs = {
      add = { text = "┃" },
      change = { text = "┃" },
      delete = { text = "" },
      topdelete = { text = "" },
      changedelete = { text = "┃" },
      untracked = { text = "┃" },
    },
    current_line_blame = true,
  },
  config = function(_, opts)
    require("gitsigns").setup(opts)
    local gitsigns = require("gitsigns")
    vim.keymap.set("n", "<leader>ph", gitsigns.preview_hunk)
    vim.keymap.set("n", "<leader>hi", gitsigns.preview_hunk_inline)
  end,
}
