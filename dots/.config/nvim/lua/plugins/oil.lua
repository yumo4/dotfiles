return {
	-- Oil
	"stevearc/oil.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		vim.keymap.set("n", "-", "<CMD>Oil<CR>", { noremap = true, silent = true })

		require("oil").setup({
			watch_for_changes = true,
			columns = { "icon" },
			keymaps = {
				["<C-h>"] = false,
			},
			view_options = {
				show_hidden = true,
			},
		})
	end,
}
