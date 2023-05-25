require('nvim-tree').setup({
    view = { relativenumber = true },
    git = { ignore = false }, -- show gitignored files
})

vim.keymap.set('n', '<leader>pv', vim.cmd.NvimTreeToggle)
