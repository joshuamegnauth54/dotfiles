require("catppuccin").setup({
	integrations = {
		blink_cmp = {
			style = "bordered",
		},
		blink_indent = true,
		blink_pairs = true,
		dap = true,
		dap_ui = true,
		fzf = true,
		gitsigns = true,
		illuminate = {
			enabled = true,
			lsp = true,
		},
		markdown = true,
		mini = true,
		native_lsp = {
			enabled = true,
			inlay_hints = {
				background = true,
			},
		},
		neotest = true,
		noice = true,
		nvim_surround = true,
		nvimtree = true,
		semantic_tokens = true,
		symbols_outline = true,
		telescope = {
			enabled = true,
		},
		treesitter = true,
		treesitter_context = true,
	},
})

vim.cmd.colorscheme("catppuccin")
