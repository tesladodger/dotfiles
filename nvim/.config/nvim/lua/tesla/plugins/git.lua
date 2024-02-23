return {
    {
        'tpope/vim-fugitive',
        config = function()
            vim.keymap.set('n', '<leader>df', '<cmd>G diff %<CR>')
            vim.keymap.set('n', '<leader>bf', '<cmd>G blame %<CR>')
        end
    },
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup({})

            vim.keymap.set('n', '<leader>bl', '<cmd>Gitsigns toggle_current_line_blame<CR>')
        end
    }
}
