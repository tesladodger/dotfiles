return {
    {
        'L3MON4D3/LuaSnip',
        version = 'v2.*',
        config = function()
            local ls = require('luasnip')

            ls.config.set_config({
                history = true,
                updateevents = 'TextChanged,TextChangedI',
            })

            -- Select within a list of options for a snippet item.
            vim.keymap.set({ 'i', 's' }, '<C-l>', function()
                if ls.choice_active() then
                    ls.change_choice(1)
                end
            end)
        end
    }
}
