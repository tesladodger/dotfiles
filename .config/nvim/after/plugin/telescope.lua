local builtin = require('telescope.builtin')

vim.keymap.set('n', '<C-p>', ':Telescope git_files hidden=true<CR>', {})
vim.keymap.set('n', '<leader>pf', ':Telescope find_files hidden=true no_ignore=true<CR>', {})
vim.keymap.set('n', '<leader>pd', builtin.diagnostics, {})
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input('Grep > ') })
end)

vim.keymap.set('n', '<leader>ls', builtin.buffers, {})
