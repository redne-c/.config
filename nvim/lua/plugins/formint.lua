return {
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        opts = {
            notify_on_error = false,
            format_on_save = function(bufnr)
                local disbale_filetypes = { c = true, cpp = true }
                if disbale_filetypes[vim.bo[bufnr].filetype] then
                    return nil
                else
                    return {
                        timrout_ms = 500,
                        lsp_format = "fallback",
                    }
                end
            end,
            formatter_by_ft = {
                lua = { "stylelua" },
                swift = { "swiftformat" },
            },
        },
    },
    {
        "mfussenegger/nvim-lint",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local lint = require("lint")
            lint.linters_by_ft = {
                markdown = { "markdownlint" },
                swift = { "swiftlint" },
            }

            local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
            vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
                group = lint_augroup,
                callback = function()
                    if vim.bo.modifiable then lint.try_lint() end
                end,
            })
        end
    }
}
