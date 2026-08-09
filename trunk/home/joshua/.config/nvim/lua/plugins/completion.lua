-- Code completion and snippets

return {
	-- https://github.com/Saghen/blink.cmp
	{
		"saghen/blink.cmp",
		dependencies = {
			"saghen/blink.compat",
		},
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
			},
			providers = {
				crates = {
					name = "crates",
					module = "blink.compat/source",
				},
			},
			sources = {
				default = { "buffer", "crates", "lsp", "path", "snippets" },
			},
			signature = {
				enabled = true,
			},
		},
	},
}
