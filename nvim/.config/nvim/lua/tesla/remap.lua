vim.g.mapleader = ' '

-- don't replace the register when pasting in visual mode
vim.keymap.set('x', '<leader>p', [["_dP]])

-- copy to the system clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])
vim.keymap.set('n', '<leader>Y', [["+Y]])

-- center cursor after Ctrl+d and Ctrl+u
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- center cursor when navigating search results
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- switch windows with <Ctrl+[hjkl]>
vim.keymap.set('n', '<C-h>', '<C-w><C-h>')
vim.keymap.set('n', '<C-j>', '<C-w><C-j>')
vim.keymap.set('n', '<C-k>', '<C-w><C-k>')
vim.keymap.set('n', '<C-l>', '<C-w><C-l>')

vim.keymap.set('i', 'jj', '<Esc>o')
vim.keymap.set('i', 'jk', '<Esc>O')

vim.keymap.set('v', 'J', [[:m '>+1<CR>gv=gv]])
vim.keymap.set('v', 'K', [[:m '<-2<CR>gv=gv]])

-- global substitution of visual selection
vim.keymap.set('x', 'gs', [[y:%s/<C-r>"//g<Left><Left>]])
-- global substitution of word under the cursor
vim.keymap.set('n', '<leader>gs', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- toggle spellcheck
vim.keymap.set('n', '<leader>z', function()
    vim.opt.spell = not (vim.opt.spell:get())
end)

-- open a terminal buffer
vim.keymap.set('n', '<leader>t', '<cmd>term<CR>i')
-- in a terminal buffer, go back to normal mode by pressing <Esc>
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

-- run the sessionizer directly from nvim (only works when already in tmux).
vim.keymap.set('n', '<C-t>', '<cmd>silent !tmux neww tmux-sessionizer<CR>')
