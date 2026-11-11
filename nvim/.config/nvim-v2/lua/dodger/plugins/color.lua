function SetColorscheme(color)
    -- color = color or 'tokyonight-night'
    color = color or 'kanagawa'
    vim.cmd.colorscheme(color)
end

return {
    {
        'folke/tokyonight.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            require('tokyonight').setup({
                styles = {
                    functions = { italic = false },
                    comments = { italic = false },
                    keywords = { italic = false },
                    sidebars = 'dark',
                    floats = 'normal',
                },

                on_colors = function(colors)
                    colors.bg = '#151510'
                    colors.bg_float = colors.bg
                    colors.comment = '#666F96'
                end,
            })
        end,
    },
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        priority = 1001,
        config = function()
            -- Default options:
            require('kanagawa').setup({
                commentStyle = { italic = false },
                functionStyle = { italic = false },
                keywordStyle = { italic = false },
                statementStyle = { bold = false },
                theme = "wave",
                background = {
                    dark = "wave",
                    light = "lotus"
                },
            })

            SetColorscheme()
        end,
    },
}
