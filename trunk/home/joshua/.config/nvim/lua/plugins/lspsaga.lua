-- LSP Saga configs for a superior LSP experience.

local quit_keys = { "q", "<ESC>" }
local quit_default = "<ESC>"

return {
	{
		"glepnir/lspsaga.nvim",
		-- config = true,
		event = { "LspAttach" },
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
		keys = {
			{ "gh", "<cmd>Lspsaga lsp_finder<cr>", desc = "Find symbol's definition" },
			{ "<leader>ca", "<cmd>Lspsaga code_action<cr>", desc = "Code action", mode = { "n", "v" } },
			-- { "<leader>gr", "<cmd>Lspsaga rename<cr>", desc = "Rename symbol (file)" },
			{ "<F2>", "<cmd>Lspsaga rename ++project<cr>", desc = "Rename symbol (workspace)" },
			{ "gp", "<cmd>Lspsaga peek_definition<cr>", desc = "Peek definition" },
			{ "gd", "<cmd>Lspsaga goto_definition<cr>", desc = "Go to definition" },
			{ "gt", "<cmd>Lspsaga peek_type_definition<cr>", desc = "Peek type definition" },
			{
				"z",
				"<cmd>Lspsaga show_line_diagnostics ++unfocus<cr>",
				desc = "Show line diagnostics",
				mode = { "n", "v" },
			},
			{ "[e", "<cmd>Lspsaga diagonostic_jump_prev<cr>", desc = "Jump to previous diagnostic" },
			{ "]e", "<cmd>Lspsaga diagonostic_jump_next<cr>", desc = "Jump to next diagnostic" },
			{ "t", "<cmd>Lspsaga outline<cr>", desc = "Symbols outline" },
			{ "K", "<cmd>Lspsaga hover_doc ++quiet<cr>", desc = "Show documentation" },
			{ "ci", "<cmd>Lspsaga incoming_calls<cr>", desc = "Incoming calls" },
			{ "co", "<cmd>Lspsaga outgoing_calls<cr>", desc = "Outgoing calls" },
		},
		opts = {
			ui = {
				kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind(),
			},
			definition = {
				quit = quit_keys,
			},
			code_action = {
				keys = {
					quit = quit_keys,
				},
			},
			lightbulb = {
				virtual_text = false,
			},
			hover = {
				-- Open documentation in a private tab
				-- open_link = "",
				open_browser = "!firefox -private ",
			},
			rename = {
				quit = quit_default,
			},
			outline = {
				keys = {
					quit = quit_default,
				},
			},
			callhierarchy = {
				keys = {
					quit = quit_keys,
				},
			},
			diagnostic = {
				keys = {
					quit = quit_default,
				},
			},
			symbol_in_winbar = {
				enable = false,
			},
		},
	},
}
