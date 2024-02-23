return {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = false,
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    config = function()
        require('nvim-tree').setup({
            view = {
                relativenumber = true,
                width = 40
            },
            git = { ignore = false }, -- show gitignored files
        })

        vim.keymap.set('n', '<leader>pv', vim.cmd.NvimTreeToggle)
    end,
}
