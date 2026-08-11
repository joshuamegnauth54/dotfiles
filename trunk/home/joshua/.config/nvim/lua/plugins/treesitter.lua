-- Treesitter configs; partially copied from https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/treesitter.lua
return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		event = { "BufReadPost", "BufNewFile" },
		keys = {
			{ "<c-space>", desc = "Increment selection" },
			{ "<bs>", desc = "Decrement selection", mode = "x" },
		},
		dependencies = {
			"nvim-treesitter/nvim-treesitter-context",
			"nvim-treesitter/nvim-treesitter-textobjects",
			-- Context aware commenting using nvim's commentString buffer and treesitter
			-- `gcc`
			"JoosepAlviste/nvim-ts-context-commentstring",
			-- Automatically complete tags for HTML, TypeScript React, et cetera
			"windwp/nvim-ts-autotag",
		},
		config = function()
			local treesitter = require("nvim-treesitter")
			treesitter.install({
				"asm",
				"awk",
				"bash",
				"bibtex",
				"bp",
				"bpftrace",
				"c",
				"c_sharp",
				"capnp",
				"cmake",
				"comment",
				"cpon",
				"cpp",
				"css",
				"csv",
				"cuda",
				"desktop",
				"devicetree",
				"diff",
				"disassembly",
				"dockerfile",
				"doxygen",
				"dtd",
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
				"html_tags",
				"htmldjango",
				"http",
				"hurl",
				"ini",
				"java",
				"javadoc",
				"javascript",
				"jinja",
				"jinja_inline",
				"jq",
				"jsdoc",
				"json",
				"json5",
				"jsonc",
				"jsonnet",
				"jsx",
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
				"powershell",
				"printf",
				"properties",
				"proto",
				"pymanifest",
				"python",
				"qmldir",
				"qmljs",
				"query",
				"r",
				"readline",
				"regex",
				"requirements",
				"robots_txt",
				"ron",
				"rust",
				"rst",
				"slang",
				"slint",
				"sql",
				"ssh_config",
				"strace",
				"svelte",
				"systemtap",
				"textproto",
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
				"wit",
				"xcompose",
				"xml",
				"xresources",
				"yaml",
				"zig",
			})

			vim.api.nvim_create_autocmd("FileType", {
				callback = function(ev)
					local lang = vim.treesitter.language.get_lang(vim.bo[ev.buf].filetype)

					if not lang or not vim.treesitter.language.add(lang) then
						return
					end

					-- Highlighting
					vim.treesitter.start(ev.buf, lang)

					-- Treesitter indentation
					vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

					-- Treesitter folding
					vim.wo[0][0].foldmethod = "expr"
					vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
				end,
			})

			-- Incremental Treesitter selection.
			vim.keymap.set("x", "<C-Space>", function()
				vim.treesitter.select("parent")
			end, { desc = "Expand selection" })

			vim.keymap.set("x", "<BS>", function()
				vim.treesitter.select("child")
			end, { desc = "Shrink selection" })

			-- Treesitter textobjects.
			require("nvim-treesitter-textobjects").setup({
				select = {
					lookahead = true,
				},
				move = {
					set_jumps = true,
				},
			})

			local select = require("nvim-treesitter-textobjects.select")

			vim.keymap.set({ "x", "o" }, "af", function()
				select.select_textobject("@function.outer", "textobjects")
			end, { desc = "Select function" })

			vim.keymap.set({ "x", "o" }, "if", function()
				select.select_textobject("@function.inner", "textobjects")
			end, { desc = "Select function body" })

			local move = require("nvim-treesitter-textobjects.move")

			vim.keymap.set({ "n", "x", "o" }, "]m", function()
				move.goto_next_start("@function.outer", "textobjects")
			end, { desc = "Next function" })

			vim.keymap.set({ "n", "x", "o" }, "[m", function()
				move.goto_previous_start("@function.outer", "textobjects")
			end, { desc = "Previous function" })
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {},
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		lazy = true,
		opts = {
			enable_autocmd = false,
		},
	},
	{
		"windwp/nvim-ts-autotag",
		opts = {},
	},
}
