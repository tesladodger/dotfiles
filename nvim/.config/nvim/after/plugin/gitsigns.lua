require('gitsigns').setup()

vim.keymap.set('n', '<leader>bl', '<cmd>Gitsigns toggle_current_line_blame<CR>')
