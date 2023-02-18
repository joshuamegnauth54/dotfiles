-- Dependencies for other packages or packages common to every environment

return {
    {
        "nvim-lua/plenary.nvim",
        lazy = true
    },
    {
        "kyazdani42/nvim-tree.lua",
        dependencies = { "kyazdani42/nvim-web-devicons" },
        -- lazy = true,
        config = true
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "kyazdani42/nvim-web-devicons" },
        lazy = true,
        config = true
    }
}
