-- vim.cmd.colorscheme "catppuccin-nvim"
vim.cmd.colorscheme "tokyonight-moon"

-- Only the editor stays transparent. nvim-tree / outline backgrounds are left
-- to the colorscheme (tokyonight-moon). NormalNC keeps a focused-out editor
-- window transparent instead of falling back to the theme's solid bg.
local transparent_groups = {
    "Normal",
    "NormalNC",
    "NormalFloat",
    "SignColumn",
    "LineNr",
}

for _, group in ipairs(transparent_groups) do
    vim.api.nvim_set_hl(0, group, { bg = "none" })
end

-- Brighten the line numbers (transparent bg kept)
local line_number_fg = "#848898"        -- non-current lines (also relative numbers)
local cursor_line_number_fg = "#ff9e64" -- the current line number (orange)
vim.api.nvim_set_hl(0, "LineNr", { fg = line_number_fg, bg = "none" })
vim.api.nvim_set_hl(0, "LineNrAbove", { fg = line_number_fg, bg = "none" })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = line_number_fg, bg = "none" })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = cursor_line_number_fg, bg = "none", bold = true })
