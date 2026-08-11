-- Dependencies for other packages or packages common to every environment
-- In other words, packages I can't fit anywhere else

return {
	-- File manager
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		cmd = "NvimTreeToggle",
		config = true,
	},
	-- Better status line
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				theme = "catppuccin-nvim",
				globalstatus = true,
			},
		},
	},
	-- Indentation guidelines
	{
		"saghen/blink.indent",
		event = "BufReadPre",
		opts = {
			scope = {
				enabled = true,
				highlights = { "BlinkIndentBlue" },
			},
		},
	},
	-- Show git status signs
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
	},
	-- Highlight same uses of a term with treesitter
	{
		"RRethy/vim-illuminate",
		event = { "BufReadPost", "BufNewFile" },
	},
	-- Automatically close pairs (brackets, parenthesis)
	{
		"saghen/blink.pairs",
		dependencies = {
			"saghen/blink.lib",
		},
		build = function()
			require("blink.pairs").build():pwait(60000)
		end,
		event = "InsertEnter",
	},
	-- Highlight color strings as the color themselves
	{
		"NvChad/nvim-colorizer.lua",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			filetypes = {
				"*",
				css = { css = true, tailwind = true },
			},
		},
	},
	{
		"echasnovski/mini.comment",
		config = true,
	},
	-- Surround motions for Neovim
	-- Allows replacing surrounding brackets or HTML tags easily
	{
		"kylechui/nvim-surround",
		event = "VeryLazy",
		config = true,
	},
}
