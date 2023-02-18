return {
    {
        -- Mason is a package manager for LSPs, DAPs, linters, and formatters
        -- https://github.com/williamboman/mason.nvim
        "williamboman/mason.nvim",
        lazy = false
    },
    {
        "williamboman/mason-lspconfig.nvim",
        lazy = true
    },
    {
        -- Quick language server configs
        "neovim/nvim-lspconfig",
        lazy = true
    },
    {
        -- More pleasant Rust experience
        "simrat39/rust-tools.nvim",
        opts = {
            server = {
                on_attach = function(_, bufnr)
                -- Hover actions
                vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
                -- Code action groups
                vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
            end
            }
        },
        lazy = true,
        config = true
    }
}
