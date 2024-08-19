return {
	{
		-- gruvbox
		"ellisonleao/gruvbox.nvim",
		config = function()
			vim.cmd.colorscheme("gruvbox")
		end,
	},
    -- {
    --     -- everforest
    --     "neanias/everforest-nvim",
    --     config = function ()
    --         require("everforest").setup({
    --             background = "soft",
    --         })
    --         vim.cmd.colorscheme("everforest")
    --     end,
    -- },
}
