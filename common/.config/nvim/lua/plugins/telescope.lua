return {
    {
        -- telescope
     "nvim-telescope/telescope.nvim",
     tag = "0.1.x",
     dependencies = {
            "nvim-lua/plenary.nvim",
            "sharkdp/fd",
            "nvim-treesitter/nvim-treesitter",
        },
     config = function()
         local builtin = require("telescope.builtin")
         vim.keymap.set("n", "<Leader>ff", builtin.find_files, {})
         vim.keymap.set("n", "<Leader>sf", builtin.current_buffer_fuzzy_find, {})
         vim.keymap.set("n", "<Leader>lg", builtin.live_grep, {})
     end
    },
    {
        -- telescope-ui-select
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
            require("telescope").setup ({
              extensions = {
                ["ui-select"] = {
                  require("telescope.themes").get_dropdown {
                      }
                  }
              }
            })
            require("telescope").load_extension("ui-select")
        end
    },
}
