-- https://github.com/folke/trouble.nvim
return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		use_diagnostic_signs = true,
	},
	cmd = {
		"Trouble",
	},
	keys = {
		{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Toggle Trouble (workspace)" },
		{ "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Toggle Trouble (document)" },
	},
}
