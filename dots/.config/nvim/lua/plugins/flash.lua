return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {},
  jump = {
    autojump = true,
  },
  -- stylua: ignore
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
	-- use this per default -> how?
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
  config = function()
    -- Set highlight for FlashLabel (the jump keys)
    -- vim.api.nvim_set_hl(0, "FlashLabel", { fg = "#1d2021", bg = "#458588" })
    vim.api.nvim_set_hl(0, "FlashLabel", { bg = "#458588" })
  end,
}
