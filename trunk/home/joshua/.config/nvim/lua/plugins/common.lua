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
		opts = {
			on_attach = function(bufnr)
				local gitsigns = require("gitsigns")

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map("n", "]c", function()
					if vim.wo.diff then
						vim.cmd.normal({ "]c", bang = true })
					else
						gitsigns.nav_hunk("next")
					end
				end)

				map("n", "[c", function()
					if vim.wo.diff then
						vim.cmd.normal({ "[c", bang = true })
					else
						gitsigns.nav_hunk("prev")
					end
				end)

				-- Actions
				map("n", "<leader>hs", gitsigns.stage_hunk)
				map("n", "<leader>hr", gitsigns.reset_hunk)
				map("v", "<leader>hs", function()
					gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end)
				map("v", "<leader>hr", function()
					gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end)
				map("n", "<leader>hS", gitsigns.stage_buffer)
				map("n", "<leader>hu", gitsigns.undo_stage_hunk)
				map("n", "<leader>hR", gitsigns.reset_buffer)
				map("n", "<leader>hp", gitsigns.preview_hunk)
				map("n", "<leader>hb", function()
					gitsigns.blame_line({ full = true })
				end)
				map("n", "<leader>tb", gitsigns.toggle_current_line_blame)
				map("n", "<leader>hd", gitsigns.diffthis)
				map("n", "<leader>hD", function()
					gitsigns.diffthis("~")
				end)
				map("n", "<leader>td", gitsigns.toggle_deleted)

				-- Text object
				map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
			end,
		},
		config = true,
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
