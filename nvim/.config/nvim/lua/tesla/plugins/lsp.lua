return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    dependencies = {
        -- LSP Support
        { 'neovim/nvim-lspconfig' },
        { 'williamboman/mason.nvim' },
        { 'williamboman/mason-lspconfig.nvim' },
        { 'nvimtools/none-ls.nvim' },

        -- Autocompletion
        { 'hrsh7th/nvim-cmp' },
        { 'hrsh7th/cmp-path' },
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/cmp-nvim-lua' },
        { 'saadparwaiz1/cmp_luasnip' },

        -- Snippets
        { 'L3MON4D3/LuaSnip' },
        { 'rafamadriz/friendly-snippets' },
    },
    config = function()
        --------------
        -- lsp-zero --
        --------------

        local lsp = require('lsp-zero')

        lsp.on_attach(function(_, bufnr)
            local opts = { buffer = bufnr, remap = false }

            vim.keymap.set('n', '<leader>gd', function() vim.lsp.buf.definition() end, opts)
            vim.keymap.set('n', '<leader>h', function() vim.lsp.buf.hover() end, opts)

            vim.keymap.set('n', '<leader>vd', function() vim.diagnostic.open_float() end, opts)

            vim.keymap.set('n', '<leader>vca', function() vim.lsp.buf.code_action() end, opts)
            vim.keymap.set('n', '<leader>vrr', function() vim.lsp.buf.references() end, opts)
            vim.keymap.set('n', '<leader>rn', function() vim.lsp.buf.rename() end, opts)

            vim.keymap.set('i', '<C-s>', function() vim.lsp.buf.signature_help() end, opts)
        end)

        require('mason').setup({})
        require('mason-lspconfig').setup({
            ensure_installed = {
                'lua_ls',
                'tsserver',
                'eslint',
                'tailwindcss',
                'gopls',
                'rust_analyzer',
                'html',
                'jsonls',
                'yamlls',
                'bashls',
                'cmake',
                'dockerls',
                'docker_compose_language_service',
            },
            handlers = {
                lsp.default_setup,
            },
        })

        lsp.format_on_save({
            format_opts = {
                timeout_ms = 10000,
            },
            servers = {
                ['lua_ls'] = { 'lua' },
                ['gopls'] = { 'go' },
                ['eslint'] = {
                    'javascript',
                    'javascriptreact',
                    'typescript',
                    'typescriptreact',
                },
                ['null-ls'] = {
                    'javascript',
                    'javascriptreact',
                    'typescript',
                    'typescriptreact',
                },
            }
        })

        local lspconf = require('lspconfig');
        lspconf.lua_ls.setup(lsp.nvim_lua_ls())
        lspconf.tsserver.setup({
            format = { enable = false },
        })
        lspconf.eslint.setup({
            on_attach = function(_, bufnr)
                vim.api.nvim_create_autocmd("BufWritePre", {
                    buffer = bufnr,
                    command = "EslintFixAll",
                })
            end,
        })
        lspconf.tailwindcss.setup({})

        ---------
        -- cmp --
        ---------

        local cmp = require('cmp')
        require('luasnip.loaders.from_vscode').lazy_load()

        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        local cmp_action = lsp.cmp_action()
        local cmp_mappings = lsp.defaults.cmp_mappings({
            ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
            ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
            ['<C-y>'] = cmp.mapping.confirm({ select = true }),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<Tab>'] = nil,
            ['<S-Tab>'] = nil,

            ['<C-k>'] = cmp_action.luasnip_jump_backward(),
            ['<C-j>'] = cmp_action.luasnip_jump_forward(),
        })

        local kind_icons = {
            Text = '',
            Method = '󰆧',
            Function = '󰊕',
            Constructor = '',
            Field = '󰇽',
            Variable = '󰂡',
            Class = '󰠱',
            Interface = '',
            Module = '',
            Property = '󰜢',
            Unit = '',
            Value = '󰎠',
            Enum = '',
            Keyword = '󰌋',
            Snippet = '',
            Color = '󰏘',
            File = '󰈙',
            Reference = '',
            Folder = '󰉋',
            EnumMember = '',
            Constant = '󰏿',
            Struct = '',
            Event = '',
            Operator = '󰆕',
            TypeParameter = '󰅲',
        }

        cmp.setup({
            sources = {
                { name = 'buffer',  keyword_length = 6 },
                { name = 'path' },
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
            },
            mapping = cmp_mappings,
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end
            },
            preselect = '',
            formatting = {
                fields = { 'abbr', 'kind' },
                format = function(_, item)
                    item.kind = string.format('%s %s', kind_icons[item.kind], item.kind)
                    return item
                end,
            },
        })

        -------------
        -- null-ls --
        -------------

        local null_ls = require('null-ls')

        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.prettier,
                -- null_ls.builtins.formatting.eslint,
            },
        })
    end
}
