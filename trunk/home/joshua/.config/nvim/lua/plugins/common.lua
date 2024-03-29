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
		opts = {
			options = {
				theme = "catppuccin",
				globalstatus = true,
			},
		},
	},
	-- Show symbols/tagged outline of source code (i.e. structs and functions)
	-- NOTE: Replaced by lspsaga for now to reduce plugins.
	-- {
	-- 	"simrat39/symbols-outline.nvim",
	-- 	config = true,
	-- 	cmd = "SymbolsOutline",
	-- 	keys = {
	-- 		{ "t", "<cmd>SymbolsOutline<cr>", desc = "Toggle symbols outline" },
	-- 	},
	-- },
	-- Indentation guidelines
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			scope = {
				enabled = true,
				injected_languages = true,
			},
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
			check_ts = true,
			enable_check_bracket_line = false,
			-- Ignore alphanumeric and .
			ignored_next_char = "[%w%.]",
		},
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
		opts = {
			options = {
				custom_commentstring = function()
					return require("ts_context_commentstring").calculate_commentstring()
				end,
			},
		},
		config = function(_, opts)
			require("mini.comment").setup(opts)
		end,
	},
	-- Highlight matching brackets
	-- NOTE: Periodically check this plugin because it's always deprecated for some reason
	{
		"HiPhish/rainbow-delimiters.nvim",
		-- lazy = true,
	},
	-- Surround motions for Neovim
	-- Allows replacing surrounding brackets or HTML tags easily
	{
		"kylechui/nvim-surround",
		event = "VeryLazy",
		config = true,
	},
}
