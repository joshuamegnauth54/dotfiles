return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				integrations = {
					dap = {
						enabled = true,
						enable_ui = true,
					},
					indent_blankline = {
						enabled = true,
					},
					illuminate = true,
					treesitter_context = true,
					ts_rainbow = true,
					ts_rainbow2 = true,
				},
			})
			vim.cmd([[colorscheme catppuccin]])
		end,
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
