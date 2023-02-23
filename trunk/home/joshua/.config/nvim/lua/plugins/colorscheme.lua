return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        priority = 1000,
        config = function()
            require("catppuccin").setup(
                {
                    integrations = {
                        indent_blankline = {
                            enabled = true
                        },
                        ts_rainbow2 = true
                    }
                }
            )
            vim.cmd([[colorscheme catppuccin]])
        end
    },
    {
        "Mofiqul/dracula.nvim",
        lazy = true,
        priority = 1000,
        -- config = function()
        --    vim.cmd([[colorscheme dracula]])
        -- end
    },
}
