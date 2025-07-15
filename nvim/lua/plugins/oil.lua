return {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    lazy = false,
    config = function()
        require("oil").setup({
            view_options = {
                show_hidden = true,
            }
        })
    end,
}
