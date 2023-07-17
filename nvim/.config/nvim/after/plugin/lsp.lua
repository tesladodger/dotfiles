--------------
-- lsp-zero --
--------------

local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.ensure_installed({
    'lua_ls',
    'tsserver',
    'eslint',
    'gopls',
    'rust_analyzer',
    'html',
    'jsonls',
})

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

lsp.format_on_save({
    format_opts = {
        timeout_ms = 10000,
    },
    servers = {
        ['lua_ls'] = { 'lua' },
        ['rust_analyzer'] = { 'rust' },
        ['gopls'] = { 'go' },
        ['null-ls'] = {
            'javascript',
            'javascriptreact',
            'typescript',
            'typescriptreact',
            'svelte',
        },
    }
})

-- Configure language servers for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
require('lspconfig').svelte.setup {}

lsp.setup()


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
        -- null_ls.builtins.diagnostics.revive,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.eslint,
        --[[
        null_ls.builtins.diagnostics.eslint.with({
            diagnostic_config = {
                underline = true,
                virtual_text = true,
                signs = true,
                update_in_insert = true,
                severity_sort = true,
            },
        }),
        ]]
    },
})
