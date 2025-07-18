return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "saghen/blink.cmp",
        {
            "folke/lazydev.nvim",
            ft = "lua", -- only load on lua files
            opts = {
                library = {
                    -- See the configuration section for more details
                    -- Load luvit types when the `vim.uv` word is found
                    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                },
            },
        }
    },
    config = function()
        local lspconfig = require("lspconfig")
        local capabilities = require("blink.cmp").get_lsp_capabilities()

        lspconfig.lua_ls.setup {
            capabilities = capabilities,
        }

        local sourcekitCapabilities = require("blink.cmp").get_lsp_capabilities({
            workspace = {
                didChangeWatchedFiles = {
                    dynamicRegistration = true,
                }
            }
        })
        lspconfig.sourcekit.setup({
            capabilities = capabilities
        })
    end,
}
