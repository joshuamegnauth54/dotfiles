-- https://github.com/stevearc/conform.nvim

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

require("conform").setup({
	-- File types that aren't listed here are handled by an LSP.
	formatters_by_ft = {
		asm = { "asmfmt" },
		bib = { "bibtex-tidy" },
		fish = { "fish_indent" },
		go = { "goimports", "gofmt" },
		-- Some file types are listed in lsp.lua too because I want injected formatting.
		-- graphql-lsp doesn't support formatting.
		graphql = { "prettierd" },
		just = { "just" },
		kotlin = { "ktlint", "injected" },
		-- ltex doesn't support formatting.
		latex = { "latexindex", "injected" },
		lua = { "stylua" },
		markdown = { "markdownlint-cli2", "injected" },
		python = { "ruff_format", "ruff_organize_imports", "injected" },
		sh = { "shellharden", "shfmt" },
		sql = { "sqlfluff" },
		toml = { "taplo" },
	},
	default_format_opts = {
		lsp_format = "fallback",
	},
})

vim.keymap.set("n", "<leader>f", function()
	require("conform").format({ async = true })
end, { desc = "Format buffer (LSP and conform)" })
