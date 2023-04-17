-- Various aesthetic plugins
return {
	-- https://github.com/stevearc/dressing.nvim
	{
		"stevearc/dressing.nvim",
		lazy = true,
	},
	-- https://github.com/folke/noice.nvim
	{
		"folke/noice.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		event = "VeryLazy",
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
			},
			views = {
				cmdline_popup = {
					border = {
						style = "none",
						padding = { 2, 3 },
					},
					filter_options = {},
					win_options = {
						winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
					},
				},
			},
		},
	},
	-- https://github.com/MunifTanjim/nui.nvim
	{ "MunifTanjim/nui.nvim", lazy = true },
	-- https://github.com/folke/todo-comments.nvim
	{
		"folke/todo-comments.nvim",
		event = { "BufReadPost", "BufNewFile" },
		cmd = { "TodoTrouble", "TodoTelescope" },
		config = true,
	},
	-- https://github.com/rcarriga/nvim-notify
	{
		"rcarriga/nvim-notify",
		event = "VeryLazy",
		config = function()
			require("notify").setup({

				render = "simple",
				stages = "static",
				timeout = 2500,
			})

			-- Replace nvim's default notify with nvim-notify
			vim.notify = require("notify")
		end,
	},
	-- https://github.com/nvim-tree/nvim-web-devicons
	{
		"nvim-tree/nvim-web-devicons",
		lazy = true,
	},
}
