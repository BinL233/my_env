return {
    'nvimdev/lspsaga.nvim',
    config = function()
        require('lspsaga').setup({
            lightbulb = {
                enable = true,
                enable_in_insert = false,
                sign = false,          -- Turn off the left gutter sign
                virtual_text = true,   -- Show the lightbulb at the end of the line
            },
        })
    end,
    dependencies = {
        'nvim-treesitter/nvim-treesitter', -- optional
        'nvim-tree/nvim-web-devicons',     -- optional
    }
}
