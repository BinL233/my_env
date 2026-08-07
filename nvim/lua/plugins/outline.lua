return {
    "hedyhli/outline.nvim",
    config = function()
        -- Example mapping to toggle outline

        require("outline").setup {
            outline_window = {
                width = 15,
                relative_width = true,
            },
        }
    end,
}
