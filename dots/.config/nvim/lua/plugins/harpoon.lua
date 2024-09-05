return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup()

		vim.keymap.set("n", "<Leader>ah", function()
			harpoon:list():add()
		end)
		vim.keymap.set("n", "<Leader>h", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end)
		vim.keymap.set("n", "<Leader>hp", function()
			harpoon:list():prev()
		end)
		vim.keymap.set("n", "<Leader>hn", function()
			harpoon:list():next()
		end)

		-- Set 1..5 be my shortcuts to moving to the files
		for _, idx in ipairs({ 1, 2, 3, 4, 5 }) do
			vim.keymap.set("n", string.format("%d", idx), function()
				harpoon:list():select(idx)
			end)
		end
	end,
}
