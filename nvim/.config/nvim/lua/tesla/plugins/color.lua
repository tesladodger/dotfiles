function SetColorscheme(color)
    color = color or 'tokyonight-night'
    vim.cmd.colorscheme(color)
end

return {
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

        SetColorscheme()
    end,
}
