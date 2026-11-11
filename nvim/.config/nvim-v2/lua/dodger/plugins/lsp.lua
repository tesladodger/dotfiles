return {
    'neovim/nvim-lspconfig',
    dependencies = {
        -- Install Language Servers
        { 'williamboman/mason.nvim' },
        { 'williamboman/mason-lspconfig.nvim' },

        -- Autocompletion
        -- { 'hrsh7th/nvim-cmp' },
        -- { 'hrsh7th/cmp-path' },
        -- { 'hrsh7th/cmp-buffer' },
        -- { 'hrsh7th/cmp-nvim-lsp' },
        -- { 'hrsh7th/cmp-nvim-lua' },
        -- { 'saadparwaiz1/cmp_luasnip' },

        -- Snippets
        -- { 'L3MON4D3/LuaSnip' },
        -- { 'rafamadriz/friendly-snippets' },
    },
    config = function()
        ----------------
        -- lsp-config --
        ----------------

        vim.opt.signcolumn = 'yes'

        vim.api.nvim_create_autocmd('LspAttach', {
            desc = 'LSP actions',
            callback = function(event)
                local opts = { buffer = event.buf }

                vim.keymap.set('n', '<leader>h', vim.lsp.buf.hover, opts)
                vim.keymap.set('i', '<C-s>', vim.lsp.buf.signature_help, opts)
                vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, opts)
                vim.keymap.set('n', '<leader>gD', vim.lsp.buf.declaration, opts)
                vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation, opts)
                vim.keymap.set('n', '<leader>go', vim.lsp.buf.type_definition, opts)

                vim.keymap.set('n', '<leader>vd', vim.diagnostic.open_float, opts)

                vim.keymap.set('n', '<leader>vca', vim.lsp.buf.code_action, opts)
                vim.keymap.set('n', '<leader>vrr', vim.lsp.buf.references, opts)
                vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
            end,
        })

        local lng_servers = {
            'lua_ls',
            'gopls',
            'rust_analyzer',
            'pylsp',
            -- 'arduino_language_server',
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

        vim.lsp.config('lua_ls', {
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { 'vim' }
                    }
                }
            }
        })
        vim.lsp.enable('lua_ls')
        vim.lsp.enable('gopls')
        -- vim.lsp.enable('arduino_language_server')

        if node_available then
            vim.lsp.enable('ts_ls')
            vim.lsp.enable('eslint')
            vim.lsp.enable('tailwindcss')
            vim.lsp.enable('vuels')
            vim.lsp.enable('buf_ls')
            vim.lsp.config('pylsp', {
                settings = {
                    pylsp = {
                        plugins = {
                            pycodestyle = {
                                ignore = { 'W391', 'E501' },
                                maxLineLength = 200
                            }
                        }
                    }
                },
            })
            vim.lsp.enable('pylsp')
        end
    end
}
