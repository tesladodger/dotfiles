require('telescope').setup({
    defaults = {
        file_ignore_patterns = {
            '.git/',
        }
    }
})

require('telescope').load_extension('fzf')

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<C-p>', function()
    builtin.git_files({
        hidden = true,
        recurse_submodules = true,
    })
end)

vim.keymap.set('n', '<leader>pf', function()
    builtin.find_files({
        hidden = true,
        no_ignore = true,
        recurse_submodules = true,
    })
end)

vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({
        search = vim.fn.input('Grep > '),
        additional_args = { '--hidden', '--glob', '!**/.git/*' },
    })
end)

vim.keymap.set('n', '<leader>ls', builtin.buffers, {})
vim.keymap.set('n', '<leader>pd', builtin.diagnostics, {})
vim.keymap.set('n', '<leader>/', function()
    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        previewer = false,
    })
end, { desc = '[/] Fuzzily search in current buffer' })
