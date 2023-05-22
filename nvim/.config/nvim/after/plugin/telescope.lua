local builtin = require('telescope.builtin')

vim.keymap.set('n', '<C-p>', function()
    builtin.git_files({ hidden = true })
end)

vim.keymap.set('n', '<leader>pf', function()
    builtin.find_files({ hidden = true, no_ignore = true })
end)

vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({
        search = vim.fn.input('Grep > '),
        additional_args = { '--hidden' },
    })
end)

vim.keymap.set('n', '<leader>ls', builtin.buffers, {})
vim.keymap.set('n', '<leader>pd', builtin.diagnostics, {})
