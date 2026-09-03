-- Dependencies for other packages or packages common to every environment.
-- In other words, packages I can't fit anywhere else.

-- Git status in the sign column, hunk staging, blame, etc.
require("gitsigns").setup()

-- Better status line
require("lualine").setup({
	options = {
		theme = "catppuccin-nvim",
		globalstatus = true,
	},
})

-- Indentation guidelines
require("blink.indent").setup({
	scope = {
		enabled = true,
		highlights = { "BlinkIndentBlue" },
	},
})

-- Highlight color strings as the color themselves
require("colorizer").setup({
	filetypes = {
		"*",
		css = { css = true, tailwind = true },
	},
})

-- Automatically close pairs (brackets, parenthesis)
-- The build hook for blink.pairs is in plugman.lua.

-- Comment motions
require("mini.comment").setup()

-- Surround motions for Neovim.
-- Allows replacing surrounding brackets or HTML tags easily.
require("nvim-surround").setup()
