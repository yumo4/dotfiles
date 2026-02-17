return {
  "sindrets/diffview.nvim",
  config = function()
    local actions = require("diffview.actions")

    require("diffview").setup({
      diff_binaries = false,
      use_icons = true,
      view = {
        merge_tool = {
          layout = "diff3_horizontal",
          disable_diagnostics = true,
        },
      },
      keymaps = {
        view = {
          ["<leader>co"] = actions.conflict_choose("ours"), -- Pick 'ours'
          ["<leader>ct"] = actions.conflict_choose("theirs"), -- Pick 'theirs"
          ["<leader>cb"] = actions.conflict_choose("base"), -- Pick 'base'
          ["<leader>ca"] = actions.conflict_choose("all"), -- Pick both
          ["<leader>cO"] = actions.conflict_choose("ours"), -- Pick 'ours' for whole file
          ["<leader>cT"] = actions.conflict_choose("theirs"), -- Pick 'theirs' for whole file
          ["<leader>dd"] = actions.toggle_files, -- Toggle file panel
        },
        file_panel = {
          ["j"] = actions.next_entry,
          ["k"] = actions.prev_entry,
          ["<cr>"] = actions.select_entry,
        },
      },
    })

    vim.keymap.set("n", "<leader>gm", function()
      local lib = require("diffview.lib")
      if next(lib.views) == nil then
        vim.cmd("DiffviewOpen")
      else
        vim.cmd("DiffviewClose")
      end
    end, { desc = "Toggle Diffview" })
  end,
}
