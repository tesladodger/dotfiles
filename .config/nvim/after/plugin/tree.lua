require('nvim-tree').setup({ view = { relativenumber = true } })

vim.keymap.set('n', '<C-n>', vim.cmd.NvimTreeOpen)
vim.keymap.set('n', '<C-t>', vim.cmd.NvimTreeToggle)
