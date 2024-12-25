return {
  "OXY2DEV/markview.nvim",
  lazy = false, -- Recommended to load immediately

  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },

  config = function()
    require("markview").setup({})
  end,
}
