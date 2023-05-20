vim.g.mapleader = " "

-- don't replace the register when pasting in visual mode
vim.keymap.set("x", "<leader>p", "\"_dP")

-- copy to the system clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- center cursor after Ctrl+d and Ctrl+u
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- center cursor when navigating search results
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- switch windows with <Ctrl+[hjkl]
vim.keymap.set("n", "<C-h>", "<C-w><C-h>")
vim.keymap.set("n", "<C-j>", "<C-w><C-j>")
vim.keymap.set("n", "<C-k>", "<C-w><C-k>")
vim.keymap.set("n", "<C-l>", "<C-w><C-l>")

vim.keymap.set("i", "jj", "<Esc>o")
vim.keymap.set("i", "jk", "<Esc>O")

-- global substitution of visual selection
vim.keymap.set("x", "gs", "y:%s/<C-r>\"//g<Left><Left>")

-- toggle spellcheck
vim.keymap.set("n", "<leader>z", function()
    vim.opt.spell = not (vim.opt.spell:get())
end)
