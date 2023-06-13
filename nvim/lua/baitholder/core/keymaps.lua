vim.g.mapleader = " "
vim.keymap.set("n", "<leader>fv", vim.cmd.Ex)

vim.keymap.set("x", "<leader>p", [["_dP]])

-- Move v down / up
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")  
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Append current line to the one up with space
vim.keymap.set("n", "J", "mzJ`z")

-- Half page down up
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Search in center of the screen
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Takes value to clip
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
