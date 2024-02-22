-- window movement
vim.keymap.set("n", "<C-h>", "<C-w>h", { silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { silent = true })
-- insert-mode movement
vim.keymap.set("i", "<C-h>", "<Left>", { silent = true })
vim.keymap.set("i", "<C-l>", "<Right>", { silent = true })
vim.keymap.set("i", "<C-j>", "<Down>", { silent = true })
vim.keymap.set("i", "<C-k>", "<Up>", { silent = true })
-- move selected text
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
--  vertical split
vim.keymap.set("n", "<Leader>vs", ":vsplit<CR>", { silent = true })
-- search highlight off
vim.keymap.set("n", "<Leader>ho", ":noh<CR>", { silent = true })
