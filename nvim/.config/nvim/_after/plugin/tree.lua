require('nvim-tree').setup({
    view = {
        relativenumber = true,
        width = 40
    },
    git = { ignore = false }, -- show gitignored files
})

vim.keymap.set('n', '<leader>pv', vim.cmd.NvimTreeToggle)
