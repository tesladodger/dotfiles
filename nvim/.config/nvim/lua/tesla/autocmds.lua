local function augroup(name)
    return vim.api.nvim_create_augroup('tesla_' .. name, {})
end

-- Set spell checker for some file types.
vim.api.nvim_create_autocmd('FileType', {
    group = augroup('auto_spellcheck'),
    pattern = 'gitcommit,tex,markdown',
    command = 'setlocal spell spelllang=en',
})

-- LSP format on save.
vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function()
        if vim.bo.modified == true then
            vim.cmd('lua vim.lsp.buf.format()')
        end
    end
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
