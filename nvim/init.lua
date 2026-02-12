local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('options')
require("lazy").setup({
    spec = {
        { import = "plugins" }
    }
})

require('keymaps')
require('lsp')
require('treesitter-config')

vim.cmd.colorscheme "catppuccin"

-- require'nvim-treesitter'.install { 'rust', 'javascript', 'zig', "go", "python", "java", "c", "markdown", "scala" }
-- Force Function Definitions (e.g., func main) to be Blue
vim.api.nvim_set_hl(0, "@function", { fg = "#61AFEF", bold = true })
vim.api.nvim_set_hl(0, "@function.builtin", { fg = "#E5C07B" }) -- Built-ins like make, len

-- Force Function Calls (e.g., fmt.Println) to be Blue
vim.api.nvim_set_hl(0, "@function.call", { fg = "#61AFEF" })
vim.api.nvim_set_hl(0, "@method.call", { fg = "#61AFEF" })

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

vim.opt.hlsearch = true

