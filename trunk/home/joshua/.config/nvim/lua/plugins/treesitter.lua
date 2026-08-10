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
			-- Enable Treesitter highlighting for every filetype for which
			-- a parser is available.
			vim.api.nvim_create_autocmd("FileType", {
				callback = function(ev)
					local lang = vim.treesitter.language.get_lang(vim.bo[ev.buf].filetype)

					if lang and vim.treesitter.language.add(lang) then
						vim.treesitter.start(ev.buf, lang)
					end
				end,
			})

			-- Treesitter-based indentation.
			vim.api.nvim_create_autocmd("FileType", {
				callback = function(ev)
					local lang = vim.treesitter.language.get_lang(vim.bo[ev.buf].filetype)

					if lang and vim.treesitter.language.add(lang) then
						vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			})

			-- Treesitter-based folding.
			vim.api.nvim_create_autocmd("FileType", {
				callback = function(ev)
					local lang = vim.treesitter.language.get_lang(vim.bo[ev.buf].filetype)

					if lang and vim.treesitter.language.add(lang) then
						vim.wo[0][0].foldmethod = "expr"
						vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
					end
				end,
			})

			-- Incremental selection.
			vim.keymap.set("x", "<C-Space>", function()
				vim.treesitter.select("parent")
			end, { desc = "Increment Treesitter selection" })

			vim.keymap.set("x", "<BS>", function()
				vim.treesitter.select("child")
			end, { desc = "Decrement Treesitter selection" })

			-- Treesitter textobjects.
			require("nvim-treesitter-textobjects").setup({
				select = {
					lookahead = true,
					selection_modes = {
						["@parameter.outer"] = "v",
						["@function.outer"] = "V",
						["@class.outer"] = "<C-V>",
					},
				},
				move = {
					set_jumps = true,
				},
			})

			-- Selection textobjects.
			local select = require("nvim-treesitter-textobjects.select")

			vim.keymap.set({ "x", "o" }, "af", function()
				select.select_textobject("@function.outer", "textobjects")
			end, { desc = "Select outer function" })

			vim.keymap.set({ "x", "o" }, "if", function()
				select.select_textobject("@function.inner", "textobjects")
			end, { desc = "Select inner function" })

			vim.keymap.set({ "x", "o" }, "ac", function()
				select.select_textobject("@class.outer", "textobjects")
			end, { desc = "Select outer class" })

			vim.keymap.set({ "x", "o" }, "ic", function()
				select.select_textobject("@class.inner", "textobjects")
			end, { desc = "Select inner class" })

			vim.keymap.set({ "x", "o" }, "as", function()
				select.select_textobject("@local.scope", "locals")
			end, { desc = "Select language scope" })

			-- Swap function parameters.
			local swap = require("nvim-treesitter-textobjects.swap")

			vim.keymap.set("n", "<leader>a", function()
				swap.swap_next("@parameter.inner")
			end, { desc = "Swap parameter forward" })

			vim.keymap.set("n", "<leader>A", function()
				swap.swap_previous("@parameter.inner")
			end, { desc = "Swap parameter backward" })

			-- Move between functions/classes/loops/etc.
			local move = require("nvim-treesitter-textobjects.move")

			local move_opts = { "n", "x", "o" }

			vim.keymap.set(move_opts, "]m", function()
				move.goto_next_start("@function.outer", "textobjects")
			end, { desc = "Next function" })

			vim.keymap.set(move_opts, "[m", function()
				move.goto_previous_start("@function.outer", "textobjects")
			end, { desc = "Previous function" })

			vim.keymap.set(move_opts, "]mm", function()
				move.goto_next_end("@function.outer", "textobjects")
			end, { desc = "End of next function" })

			vim.keymap.set(move_opts, "[mm", function()
				move.goto_previous_end("@function.outer", "textobjects")
			end, { desc = "End of previous function" })

			vim.keymap.set(move_opts, "]]", function()
				move.goto_next_start("@class.outer", "textobjects")
			end, { desc = "Next class" })

			vim.keymap.set(move_opts, "[[", function()
				move.goto_previous_start("@class.outer", "textobjects")
			end, { desc = "Previous class" })

			vim.keymap.set(move_opts, "][", function()
				move.goto_next_end("@class.outer", "textobjects")
			end, { desc = "End of next class" })

			vim.keymap.set(move_opts, "[]", function()
				move.goto_previous_end("@class.outer", "textobjects")
			end, { desc = "End of previous class" })

			vim.keymap.set(move_opts, "]o", function()
				move.goto_next_start("@loop.*", "textobjects")
			end, { desc = "Next loop" })

			vim.keymap.set(move_opts, "]d", function()
				move.goto_next("@conditional.outer", "textobjects")
			end, { desc = "Next conditional" })

			vim.keymap.set(move_opts, "[d", function()
				move.goto_previous("@conditional.outer", "textobjects")
			end, { desc = "Previous conditional" })

			vim.keymap.set(move_opts, "]s", function()
				move.goto_next_start("@local.scope", "locals")
			end, { desc = "Next scope" })

			vim.keymap.set(move_opts, "[s", function()
				move.goto_previous_start("@local.scope", "locals")
			end, { desc = "Previous scope" })

			vim.keymap.set(move_opts, "]z", function()
				move.goto_next_start("@fold", "folds")
			end, { desc = "Next fold" })

			vim.keymap.set(move_opts, "[z", function()
				move.goto_previous_start("@fold", "folds")
			end, { desc = "Previous fold" })
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
