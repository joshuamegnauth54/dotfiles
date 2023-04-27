return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				integrations = {
					cmp = true,
					dap = {
						enabled = true,
						enable_ui = true,
					},
					gitsigns = true,
					indent_blankline = {
						enabled = true,
					},
					illuminate = true,
					lsp_trouble = true,
					markdown = true,
					mason = true,
					mini = true,
					noice = true,
					notify = true,
					nvimtree = true,
					symbols_outline = true,
					telescope = true,
					treesitter = true,
					treesitter_context = true,
					-- ts_rainbow = true,
					ts_rainbow2 = true,
				},
			})
			vim.cmd.colorscheme("catppuccin")
		end,
	},
	{
		"Mofiqul/dracula.nvim",
		lazy = true,
		priority = 1000,
		-- config = function()
		--    vim.cmd.colorscheme("dracula")
		-- end
	},
}
