local function augroup(name)
    return vim.api.nvim_create_augroup('tesla_' .. name, {})
end

-- Set spell checker for some file types.
vim.api.nvim_create_autocmd('FileType', {
    group = augroup('auto_spellcheck'),
    pattern = 'gitcommit,tex,markdown',
    command = 'setlocal spell spelllang=en',
})

-- Change indentation style for js family languages to match prettier.
vim.api.nvim_create_autocmd('FileType', {
    group = augroup('js_indent'),
    pattern = 'javascript,javascriptreact,typescript,typescriptreact',
    command = 'setlocal tabstop=2 shiftwidth=2',
})

-- Highlight on yank.
vim.api.nvim_create_autocmd('TextYankPost', {
    group = augroup('highlight_yank'),
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            timeout = 50,
        })
    end,
})
