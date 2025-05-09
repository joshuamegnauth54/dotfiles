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
				-- Context aware commenting using nvim's commentString buffer and treesitter
				-- `gcc`
				"JoosepAlviste/nvim-ts-context-commentstring",
				opts = {
					enable_autocmd = false,
				},
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
			ensure_installed = {
				"angular",
				"asm",
				"astro",
                "authzed",
				"awk",
				"bash",
				"bibtex",
				"bp",
				"c",
				"c_sharp",
				"capnp",
				"cmake",
				"comment",
				"cpp",
				"css",
				"csv",
				"cuda",
				"cue",
                "desktop",
                "devicetree",
				"dhall",
				"diff",
				"disassembly",
				"dockerfile",
				"dot",
				"doxygen",
                "dtd",
				"ebnf",
                "editorconfig",
                "embedded_template",
				"fish",
				"gdscript",
				"gdshader",
				"git_config",
				"git_rebase",
				"gitattributes",
				"gitcommit",
				"gitignore",
				"glsl",
				"gnuplot",
				"go",
                "goctl",
				"godot_resource",
				"gomod",
				"gosum",
                "gotmpl",
				"gowork",
				"gpg",
				"graphql",
				"groovy",
				"gstlaunch",
				"haskell",
				"haskell_persistent",
				"hlsl",
				"html",
				"htmldjango",
				"http",
				"hurl",
				"ini",
				"java",
				"javascript",
                "jinja",
                "jinja_inline",
				"jq",
				"jsdoc",
				"json",
				"json5",
				"jsonc",
                "jsonnet",
				"julia",
				"just",
				"kdl",
                "kconfig",
				"kotlin",
				"latex",
				"linkerscript",
				"llvm",
				"lua",
				"luadoc",
				"luap",
				"luau",
				"make",
				"markdown",
				"markdown_inline",
				"meson",
				"muttrc",
				"nasm",
				"ninja",
				"nix",
				"objdump",
				"passwd",
				"pem",
				"perl",
                "pioasm",
                "printf",
				"proto",
				"pymanifest",
				"python",
				"qmldir",
				"qmljs",
				"query",
				"r",
                "re2c",
				"readline",
				"regex",
				"requirements",
                "robots",
				"ron",
				"rust",
				"rst",
				"scss",
				"slint",
				"sparql",
				"sql",
				"ssh_config",
				"starlark",
				"strace",
				"styled",
				"svelte",
				"systemtap",
				"textproto",
				"tmux",
				"toml",
				"tsv",
				"tsx",
				"typescript",
				"typst",
				"udev",
                "vala",
				"verilog",
				"vim",
				"vimdoc",
				"vue",
				"wgsl",
				"wgsl_bevy",
				"xcompose",
				"xml",
                "xresources",
				"yaml",
				"yuck",
                "zathurarc",
				"zig",
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
