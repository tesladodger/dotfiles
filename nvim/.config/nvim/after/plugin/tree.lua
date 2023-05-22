require('nvim-tree').setup({
    view = { relativenumber = true }
})

vim.keymap.set('n', '<leader>pv', vim.cmd.NvimTreeToggle)
