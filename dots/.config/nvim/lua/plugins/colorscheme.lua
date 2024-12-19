return {
  -- Colorscheme
  "ellisonleao/gruvbox.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("gruvbox")

    -- You can configure highlights by doing something like
    vim.cmd.hi("Comment gui=none")
  end,
}
