require('tokyonight').setup({
    styles = {
        functions = { italic = true },
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

require('onedark').setup({
    style = 'warmer',
    code_style = {
        comments = 'none',
        keywords = 'none',
        functions = 'italic',
        strings = 'none',
        variables = 'none',
    }
})

function SetColorscheme(color)
    color = color or 'tokyonight-night'
    vim.cmd.colorscheme(color)
end

SetColorscheme()
