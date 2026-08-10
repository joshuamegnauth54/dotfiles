-- Code completion and snippets

return {
	-- https://github.com/Saghen/blink.cmp
	{
		"saghen/blink.cmp",
		dependencies = {
			"xzbdmw/colorful-menu.nvim",
			-- "https://github.com/rafamadriz/friendly-snippets"
			"rafamadriz/friendly-snippets",
		},
		build = "cargo build --release",
		version = "1.*",
		event = "InsertEnter",
		opts = {
			keymap = {
				preset = "enter",
			},
			completion = {
				documentation = {
					auto_show = true,
				},
				ghost_text = {
					enabled = true,
				},
				menu = {
					draw = {
						columns = { { "kind_icon" }, { "label", gap = 1 } },
						components = {
							label = {
								text = function(ctx)
									return require("colorful-menu").blink_components_text(ctx)
								end,
								highlight = function(ctx)
									return require("colorful-menu").blink_components_highlight(ctx)
								end,
							},
						},
						treesitter = { "lsp" },
					},
				},
			},
			sources = {
				default = { "buffer", "lsp", "path", "snippets" },
				per_filetype = {
					lua = { inherit_defaults = true, "lazydev" },
				},
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						score_offset = 100,
					},
				},
			},
			signature = {
				enabled = true,
			},
		},
	},
	{
		-- "https://github.com/Saghen/blink.compat"
		"saghen/blink.compat",
		lazy = true,
	},
}
