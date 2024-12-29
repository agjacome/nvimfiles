return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp",
            "l3mon4d3/luasnip",
            "saadparwaiz1/cmp_luasnip",
            "j-hui/fidget.nvim",
        },
        event = "VeryLazy",
        config = function()
            require("mason").setup({})
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls"
                },
                handlers = {
                    function(server)
                        require("lspconfig")[server].setup({
                            capabilities = vim.tbl_deep_extend(
                                "force",
                                vim.lsp.protocol.make_client_capabilities(),
                                require("cmp_nvim_lsp").default_capabilities()
                            )
                        })
                    end
                }
            })

            local cmp = require("cmp")
            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-y>"]     = cmp.mapping.confirm({ select = true }),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-p>"]     = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
                    ["<C-n>"]     = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
                    ["<C-b>"]     = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"]     = cmp.mapping.scroll_docs(4),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" }
                }, {
                    { name = "buffer" },
                }),
            })

            require("fidget").setup({})

            vim.api.nvim_create_autocmd("LspAttach", {
                desc = "LSP Actions",
                callback = function()
                    vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", Opts("LSP - Hover"))
                    vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<cr>", Opts("LSP - Definition"))
                    vim.keymap.set("n", "gD", "<cmd>Telescope lsp_type_definitions<cr>", Opts("LSP - Type definition"))
                    vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<cr>", Opts("LSP - Implementation"))
                    vim.keymap.set("n", "gI", "<cmd>Telescope lsp_incoming_calls<cr>", Opts("LSP - Incoming calls"))
                    vim.keymap.set("n", "gO", "<cmd>Telescope lsp_outgoing_calls<cr>", Opts("LSP - Outgoing calls"))
                    vim.keymap.set("n", "grr", "<cmd>Telescope lsp_references<cr>", Opts("LSP - References"))
                    vim.keymap.set("n", "grn", "<cmd>lua vim.lsp.buf.rename()<cr>", Opts("LSP - Rename"))
                    vim.keymap.set("n", "gra", "<cmd>lua vim.lsp.buf.code_action()<cr>", Opts("LSP - Action"))
                    vim.keymap.set("n", "<leader>l", "<cmd>Telescope lsp_document_symbols<cr>", Opts("LSP - Symbols"))
                    vim.keymap.set("n", "<leader>L", "<cmd>Telescope lsp_workspace_symbols<cr>", Opts("LSP - Workspace symbols"))
                    vim.keymap.set({ "n", "x" }, "grf", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", Opts("LSP - Format"))
                end
            })

            vim.diagnostic.config({
                update_in_insert = false,
                float = {
                    focusable = false,
                    source = "if_many",
                    header = "",
                    prefix = "",
                },
            })
        end,
    },
    {
        "folke/lazydev.nvim",
        dependencies = {
            "bilal2453/luvit-meta",
        },
        ft = "lua",
        opts = {
            library = {
                { path = "luvit-meta/library", words = { "vim%.uv" } },
            },
        }
    },
}
