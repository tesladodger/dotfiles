return {
    'nvim-treesitter/nvim-treesitter',
    branch = "main",
    build = ':TSUpdate',
    dependencies = {
        'windwp/nvim-ts-autotag',
    },
    config = function()
        require('nvim-treesitter').install({
            'vimdoc',
            'javascript',
            'typescript',
            'go',
            'c',
            'lua',
            'vim',
            'query',
            'comment',
        })
    end
}
