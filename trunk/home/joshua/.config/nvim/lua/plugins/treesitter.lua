-- Treesitter configs; partially copied from https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/treesitter.lua
return {
	{
		"nvim-treesitter/nvim-treesitter",
		-- Treesitter parsers must be updated when treesitter is updated
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		keys = {
			{ "<c-space>", desc = "Increment selection" },
			{ "<bs>", desc = "Decrement selection", mode = "x" },
		},
		dependencies = {
			{
				"nvim-treesitter/nvim-treesitter-context",
				config = true,
			},
			{
				"nvim-treesitter/nvim-treesitter-textobjects",
			},
			{
				-- Highlight matching brackets
				-- NOTE: Periodically check this plugin because it's always deprecated for some reason
				"HiPhish/nvim-ts-rainbow2",
				-- lazy = true,
			},
			{
				-- Context aware commenting using nvim's commentString buffer and treesitter
				-- `gcc`
				"JoosepAlviste/nvim-ts-context-commentstring",
				lazy = true,
			},
			{
				-- Automatically complete tags for HTML, TypeScript React, et cetera
				"windwp/nvim-ts-autotag",
			},
		},
		---@type TSConfig
		opts = {
			highlight = { enable = true },
			indent = { enable = true },
			context_commentstring = { enable = true, enable_autocmd = false },
			ensure_installed = {
				"awk",
				"bash",
				"bibtex",
				"c",
				"c_sharp",
				"capnp",
				"cmake",
				"comment",
				"cpp",
				"css",
				"dhall",
				"diff",
				"dockerfile",
				"dot",
				"fish",
				"git_config",
				"git_rebase",
				"gitattributes",
				"gitcommit",
				"gitignore",
				"glsl",
				"go",
				"gomod",
				"gosum",
				"gowork",
				"graphql",
				"haskell",
				"help",
				"hlsl",
				"html",
				"htmldjango",
				"ini",
				"java",
				"javascript",
				"json",
				"json5",
				"julia",
				"kotlin",
				"latex",
				"llvm",
				"lua",
				"luadoc",
				"luap",
				"make",
				"markdown",
				"markdown_inline",
				"meson",
				"nix",
				"passwd",
				"python",
				"query",
				"r",
				"regex",
				"ron",
				"rust",
				"rst",
				"scss",
				"sql",
				"svelte",
				"toml",
				"tsx",
				"typescript",
				"vim",
				"vue",
				"wgsl",
				"wgsl_bevy",
				"yaml",
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = "<nop>",
					node_decremental = "<bs>",
				},
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					lsp_interop = {
						enable = true,
					},
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
						["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
					},
					selection_modes = {
						["@parameter.outer"] = "v", -- charwise
						["@function.outer"] = "V", -- linewise
						["@class.outer"] = "<c-v>", -- blockwise
					},
					-- Swap text objects, like function parameters
					swap = {
						enable = true,
						swap_next = {
							["<leader>a"] = "@parameter.inner",
						},
						swap_previous = {
							["<leader>A"] = "@parameter.inner",
						},
					},
					-- Copied from the docs with small changes
					move = {
						enable = true,
						set_jumps = true,
						goto_next_start = {
							["]m"] = "@function.outer",
							["]]"] = { query = "@class.outer", desc = "Next class start" },
							["]o"] = "@loop.*",
							["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
							["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
						},
						goto_next_end = {
							["]mm"] = "@function.outer",
							["]["] = "@class.outer",
						},
						goto_previous_start = {
							["[m"] = "@function.outer",
							["[["] = "@class.outer",
						},
						goto_previous_end = {
							["[mm"] = "@function.outer",
							["[]"] = "@class.outer",
						},
						-- Jump to either end or beginning (whichever is closer)
						goto_next = {
							["]d"] = "@conditional.outer",
						},
						goto_previous = {
							["[d"] = "@conditional.outer",
						},
					},
				},
			},
			-- nvim-ts-rainbow2
			rainbow = {
				enable = true,
				query = {
					"rainbow-parens",
					html = "rainbow-tags",
				},
				-- strategy = {
				-- require ("ts-rainbow").strategy.global,
				-- },
			},
			autotag = {
				enable = true,
			},
		},
		---@param opts TSConfig
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
}
