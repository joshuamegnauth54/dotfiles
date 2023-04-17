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
		},
		---@param opts TSConfig
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
}
