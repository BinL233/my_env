return {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
        "williamboman/mason.nvim",
        "neovim/nvim-lspconfig",
        "saghen/blink.cmp",
    },
    config = function()
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        local ok, blink = pcall(require, "blink.cmp")
        if ok then
            capabilities = blink.get_lsp_capabilities(capabilities)
        end

        require("mason-lspconfig").setup({
            ensure_installed = {
                "pyright",
                "gopls",
                "html",
                "jsonls",
                "clangd",
                "lua_ls",
            },
            handlers = {
                function(server_name)
                    require("lspconfig")[server_name].setup({
                        capabilities = capabilities,
                    })
                end,
            },
        })

        -- Manually define LspInfo for Neovim 0.11+ compatibility
        if vim.fn.exists(':LspInfo') == 0 then
            vim.api.nvim_create_user_command('LspInfo', 'checkhealth vim.lsp', { desc = 'Alias to :checkhealth vim.lsp' })
        end
    end,
}
