return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp", -- cmp_nvim_lsp
        "neovim/nvim-lspconfig", -- lspconfig
        "onsails/lspkind-nvim", -- lspkind (VS pictograms)
        {
            "L3MON4D3/LuaSnip",
            version = "v2.*",
            build = "make install_jsregexp",
            dependencies = {"rafamadriz/friendly-snippets"}, -- Snippets
            config = function()
                require("luasnip.loaders.from_vscode").lazy_load()
                -- https://github.com/rafamadriz/friendly-snippets/blob/main/snippets/go.json
            end
        }, {"saadparwaiz1/cmp_luasnip", enabled = true}
    },
config = function()
        local luasnip = require("luasnip")
        local types = require("luasnip.util.types")
        local cmp = require("cmp")
        local lspkind = require("lspkind")

        -- 1. Setup LuaSnip (Visual tweaks)
        luasnip.config.setup({
            ext_opts = {
                [types.choiceNode] = {
                    active = {virt_text = {{"⇥", "GruvboxRed"}}}
                },
                [types.insertNode] = {
                    active = {virt_text = {{"⇥", "GruvboxBlue"}}}
                }
            }
        })

        -- 2. Setup nvim-cmp
        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered()
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({select = true}),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.locally_jumpable(1) then
                        luasnip.jump(1)
                    else
                        fallback()
                    end
                end, {"i", "s"})
            }),
            sources = cmp.config.sources({
                {name = "nvim_lsp"}, 
                {name = "luasnip"}, 
                {name = "buffer"}
            }),
            formatting = {
                format = lspkind.cmp_format({
                    mode = "symbol_text",
                    maxwidth = 70,
                    show_labelDetails = true
                })
            }
        })

        -- 3. LSP Setup (The New Way for Neovim 0.11)
        
        -- Get the default capabilities from cmp-nvim-lsp
        -- (This ensures the LSP knows you can accept completions)
        local defaults = require('cmp_nvim_lsp').default_capabilities()

        -- Helper function to set up servers using the new API
        local function setup_server(name, config)
            config = config or {}
            
            -- Inject cmp capabilities into the config
            config.capabilities = vim.tbl_deep_extend(
                "force", 
                defaults, 
                config.capabilities or {}
            )

            -- Assign the config to the global vim.lsp.config table
            vim.lsp.config[name] = config
            
            -- Enable the server
            vim.lsp.enable(name)
        end

        -- Initialize your servers here
        setup_server("pyright")     -- Python
        setup_server("solargraph")  -- Ruby
        setup_server("phpactor")    -- PHP
    end
}
