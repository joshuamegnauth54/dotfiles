-- https://github.com/folke/trouble.nvim
return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		use_diagnostic_signs = true,
	},
	cmd = {
		"Trouble",
		"TroubleToggle",
		"TroubleClose",
		"TroubleRefresh",
	},
	keys = {
		{ "<leader>xx", "<cmd>TroubleToggle<cr>", desc = "Toggle Trouble (workspace)" },
		{ "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Toggle Trouble (document)" },
	},
}
