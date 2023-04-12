-- Dependencies for other packages or packages common to every environment
-- In other words, packages I can't fit anywhere else

return {
	-- Useful functions that a lot of plugins depend on
	{
		"nvim-lua/plenary.nvim",
		lazy = true,
	},
	-- File manager
	{
		"kyazdani42/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		cmd = "NvimTreeToggle",
		config = true,
	},
	-- Better status line
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = true,
	},

	-- Show tagged outline of source code (i.e. structs and functions)
	{
		"preservim/tagbar",
		cmd = "TagbarToggle",
	},
	-- Indentation guidelines
	{
		"lukas-reineke/indent-blankline.nvim",
		opts = {
			show_current_context = true,
			show_current_context_start = true,
		},
		event = "BufReadPre",
	},
	-- Show git status signs
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map("n", "]c", function()
					if vim.wo.diff then
						return "]c"
					end
					vim.schedule(function()
						gs.next_hunk()
					end)
					return "<Ignore>"
				end, { expr = true })

				map("n", "[c", function()
					if vim.wo.diff then
						return "[c"
					end
					vim.schedule(function()
						gs.prev_hunk()
					end)
					return "<Ignore>"
				end, { expr = true })

				-- Actions
				map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>")
				map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>")
				map("n", "<leader>hS", gs.stage_buffer)
				map("n", "<leader>hu", gs.undo_stage_hunk)
				map("n", "<leader>hR", gs.reset_buffer)
				map("n", "<leader>hp", gs.preview_hunk)
				map("n", "<leader>hb", function()
					gs.blame_line({ full = true })
				end)
				map("n", "<leader>tb", gs.toggle_current_line_blame)
				map("n", "<leader>hd", gs.diffthis)
				map("n", "<leader>hD", function()
					gs.diffthis("~")
				end)
				map("n", "<leader>td", gs.toggle_deleted)

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
		"windwp/nvim-autopairs",
		opts = {
			enable_check_bracket_line = false,
			-- Ignore alphanumeric and .
			ignored_next_char = "[%w%.]",
		},
		config = true,
	},
	-- Highlight color strings as the color themselves
	{
		"NvChad/nvim-colorizer.lua",
		event = { "BufReadPost", "BufNewFile" },
	},

	{
		"echasnovski/mini.comment",
		opts = {
			hooks = {
				pre = function()
					require("ts_context_commentstring.internal").update_commentstring({})
				end,
			},
		},
		config = function(_, opts)
			require("mini.comment").setup(opts)
		end,
	},
}
