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
					dap = true,
					dap_ui = true,
                    fzf = true,
					gitsigns = true,
					indent_blankline = {
						enabled = true,
					},
					illuminate = {
                        enabled = true,
                        lsp = true,
                    },
					lsp_saga = true,
					lsp_trouble = true,
					markdown = true,
					mason = true,
					mini = true,
					native_lsp = {
						enabled = true,
						inlay_hints = {
							background = true,
						},
					},
					neotest = true,
					noice = true,
					notify = true,
                    nvim_surround = true,
					nvimtree = true,
					semantic_tokens = true,
					symbols_outline = true,
					rainbow_delimiters = true,
					telescope = {
						enabled = true,
					},
					treesitter = true,
					treesitter_context = true,
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
