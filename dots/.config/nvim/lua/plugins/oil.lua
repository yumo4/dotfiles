return {
  -- Oil
  "stevearc/oil.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { noremap = true, silent = true })

    require("oil").setup({
      default_file_explorer = true,
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      watch_for_changes = true,
      columns = { "icon" },
      keymaps = {
        ["<C-h>"] = false,
        ["q"] = "actions.close",
        ["gx"] = "actions.open_external",
      },
      view_options = {
        show_hidden = true,
      },
      win_options = {
        wrap = true,
        winblend = 0,
      },
    })
  end,
}
