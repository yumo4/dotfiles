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
          { "n", "<leader>f", actions.toggle_files, { desc = "toggle files" } },
          { "n", "<tab>", actions.select_next_entry, { desc = "Open the diff for the next file" } },
          {
            "n",
            "<s-tab>",
            actions.select_prev_entry,
            { desc = "Open the diff for the previous file" },
          },
          { "n", "<leader>e", actions.focus_files, { desc = "Bring focus to the file panel" } },
          { "n", "<leader>b", actions.toggle_files, { desc = "Toggle the file panel." } },
          { "n", "g<C-x>", actions.cycle_layout, { desc = "Cycle through available layouts." } },
          {
            "n",
            "<C-p>",
            actions.prev_conflict,
            { desc = "In the merge-tool: jump to the previous conflict" },
          },
          {
            "n",
            "<C-n>",
            actions.next_conflict,
            { desc = "In the merge-tool: jump to the next conflict" },
          },
          {
            "n",
            "<leader>co",
            actions.conflict_choose("ours"),
            { desc = "Choose the OURS version of a conflict" },
          },
          {
            "n",
            "<leader>ct",
            actions.conflict_choose("theirs"),
            { desc = "Choose the THEIRS version of a conflict" },
          },
          {
            "n",
            "<leader>cb",
            actions.conflict_choose("base"),
            { desc = "Choose the BASE version of a conflict" },
          },
          {
            "n",
            "<leader>ca",
            actions.conflict_choose("all"),
            { desc = "Choose all the versions of a conflict" },
          },
          { "n", "dx", actions.conflict_choose("none"), { desc = "Delete the conflict region" } },
          {
            "n",
            "<leader>cO",
            actions.conflict_choose_all("ours"),
            { desc = "Choose the OURS version of a conflict for the whole file" },
          },
          {
            "n",
            "<leader>cT",
            actions.conflict_choose_all("theirs"),
            { desc = "Choose the THEIRS version of a conflict for the whole file" },
          },
          {
            "n",
            "<leader>cB",
            actions.conflict_choose_all("base"),
            { desc = "Choose the BASE version of a conflict for the whole file" },
          },
          {
            "n",
            "<leader>cA",
            actions.conflict_choose_all("all"),
            { desc = "Choose all the versions of a conflict for the whole file" },
          },
          {
            "n",
            "dX",
            actions.conflict_choose_all("none"),
            { desc = "Delete the conflict region for the whole file" },
          },
        },
        file_panel = {
          { "n", "<leader>f", actions.toggle_files, { desc = "toggle files" } },
          { "n", "j", actions.next_entry, { desc = "next entry" } },
          { "n", "k", actions.prev_entry, { desc = "previous entry" } },
          { "n", "<cr>", actions.select_entry, { desc = "select entry" } },
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
