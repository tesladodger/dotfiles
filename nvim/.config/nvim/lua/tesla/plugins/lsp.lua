return {
    'neovim/nvim-lspconfig',
    dependencies = {
        -- Install Language Servers
        { 'williamboman/mason.nvim' },
        { 'williamboman/mason-lspconfig.nvim' },

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
        ----------------
        -- lsp-config --
        ----------------

        vim.opt.signcolumn = 'yes'

        local lspconfig_defaults = require('lspconfig').util.default_config
        lspconfig_defaults.capabilities = vim.tbl_deep_extend(
            'force',
            lspconfig_defaults.capabilities,
            require('cmp_nvim_lsp').default_capabilities()
        )

        vim.api.nvim_create_autocmd('LspAttach', {
            desc = 'LSP actions',
            callback = function(event)
                local opts = { buffer = event.buf }

                vim.keymap.set('n', '<leader>h', function() vim.lsp.buf.hover() end, opts)
                vim.keymap.set('i', '<C-s>', function() vim.lsp.buf.signature_help() end, opts)
                vim.keymap.set('n', '<leader>gd', function() vim.lsp.buf.definition() end, opts)
                vim.keymap.set('n', '<leader>gD', function() vim.lsp.buf.declaration() end, opts)
                vim.keymap.set('n', '<leader>gi', function() vim.lsp.buf.implementation() end, opts)
                vim.keymap.set('n', '<leader>go', function() vim.lsp.buf.type_definition() end, opts)

                vim.keymap.set('n', '<leader>vd', function() vim.diagnostic.open_float() end, opts)

                vim.keymap.set('n', '<leader>vca', function() vim.lsp.buf.code_action() end, opts)
                vim.keymap.set('n', '<leader>vrr', function() vim.lsp.buf.references() end, opts)
                vim.keymap.set('n', '<leader>rn', function() vim.lsp.buf.rename() end, opts)
            end,
        })

        local lng_servers = {
            'lua_ls',
            'gopls',
            'rust_analyzer',
            'cmake',
            'pylsp',
        }

        local node_available = vim.fn.executable('node') == 1

        if node_available then
            table.insert(lng_servers, 'ts_ls')
            table.insert(lng_servers, 'eslint')
            table.insert(lng_servers, 'tailwindcss')
            table.insert(lng_servers, 'html')
            table.insert(lng_servers, 'jsonls')
            table.insert(lng_servers, 'yamlls')
            table.insert(lng_servers, 'bashls')
            table.insert(lng_servers, 'dockerls')
            table.insert(lng_servers, 'docker_compose_language_service')
            table.insert(lng_servers, 'vuels')
            table.insert(lng_servers, 'buf_ls')
        end

        require('mason').setup({})
        require('mason-lspconfig').setup({
            ensure_installed = lng_servers,
            automatic_enable = false,
        })

        local lspconf = require('lspconfig');
        lspconf.lua_ls.setup({
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { 'vim' }
                    }
                }
            }
        })
        lspconf.gopls.setup({})

        if node_available then
            lspconf.ts_ls.setup({})
            lspconf.eslint.setup({})
            lspconf.tailwindcss.setup({})
            lspconf.pylsp.setup({})
            lspconf.vuels.setup({})
            lspconf.buf_ls.setup({})
        end

        ---------
        -- cmp --
        ---------

        local cmp = require('cmp')
        require('luasnip.loaders.from_vscode').lazy_load()

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

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
                { name = 'buffer',  keyword_length = 5 },
                { name = 'path' },
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<Tab>'] = nil,
                ['<S-Tab>'] = nil,
            }),
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
    end
}
