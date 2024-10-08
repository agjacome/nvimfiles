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
                callback = function(event)
                    local opt = function(desc)
                        return { buffer = event.buffer, silent = true, desc = desc }
                    end

                    vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opt(""))

                    vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<cr>", opt("Go to definition (LSP)"))
                    vim.keymap.set("n", "gD", "<cmd>Telescope lsp_type_definitions<cr>", opt("Go to type definition (LSP)"))
                    vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<cr>", opt("Go to implementation (LSP)"))
                    vim.keymap.set("n", "gI", "<cmd>Telescope lsp_incoming_calls<cr>", opt("Go to incoming calls (LSP)"))
                    vim.keymap.set("n", "gO", "<cmd>Telescope lsp_outgoing_calls<cr>", opt("Go to outgoing calls (LSP)"))
                    vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", opt("Go to references (LSP)"))

                    vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opt("Rename symbol (LSP)"))
                    vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opt("Code action (LSP)"))

                    vim.keymap.set("n", "<leader>l", "<cmd>Telescope lsp_document_symbols<cr>", opt("List symbols (LSP)"))
                    vim.keymap.set("n", "<leader>L", "<cmd>Telescope lsp_workspace_symbols<cr>", opt("List workspace symbols (LSP)"))

                    vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opt("Format buffer (LSP)"))
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
