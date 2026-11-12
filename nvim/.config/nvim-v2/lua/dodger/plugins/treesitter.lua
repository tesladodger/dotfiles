return {
    'nvim-treesitter/nvim-treesitter',
    branch = "main",
    build = ':TSUpdate',
    dependencies = {
        'windwp/nvim-ts-autotag',
    },
    config = function()
        require('nvim-treesitter').install({
            'bash',
            'c',
            'comment',
            'go',
            'html',
            'javascript',
            'lua',
            'markdown',
            'markdown_inline',
            'query',
            'regex',
            'tsx',
            'typescript',
            'vim',
            'vimdoc',
            'yaml',
        })
    end
}
