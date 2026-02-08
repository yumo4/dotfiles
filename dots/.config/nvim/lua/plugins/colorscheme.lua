return {
    -- Colorscheme
    {
        "ellisonleao/gruvbox.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("gruvbox")

            -- You can configure highlights by doing something like
            vim.cmd.hi("Comment gui=none")
        end,
    },
    -- {
    --   "oskarnurm/koda.nvim",
    --
    --   lazy = false, -- make sure we load this during startup if it is your main colorscheme
    --   priority = 1000, -- make sure to load this before all the other start plugins
    --   config = function()
    --     -- require("koda").setup({ transparent = true })
    --     vim.cmd("colorscheme koda")
    --   end,
    -- },
}
