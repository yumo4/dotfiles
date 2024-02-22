return {
    -- neotree
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    config = function()
        vim.keymap.set("n", "<C-n>", ":Neotree filesystem toggle left <CR>", { noremap = true, silent = true })

        require("neo-tree").setup({
            filesystem = {
                filtered_items = {
                    visible = true,
                    hide_dotfiles = false,
                    hide_gitignored = true,
                    hide_hidden = false,
                },
            },
        })
    end,
}
