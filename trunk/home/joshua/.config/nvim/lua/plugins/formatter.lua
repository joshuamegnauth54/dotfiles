-- https://github.com/stevearc/conform.nvim

return {
	"stevearc/conform.nvim",
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = "",
			desc = "Format buffer (LSP and conform)",
		},
	},
	opts = {
		-- NOTE: File types that aren't listed here are handled by an LSP
		-- Some file types are listed twice (in lsp.lua and here) because I
		-- want to make use of injected formatting
		formatters_by_ft = {
			bib = { "bibtex-tidy" },
			fish = { "fish_indent" },
			-- NOTE: graphql-lsp doesn't support formatting
			graphql = { "prettierd" },
			just = { "just" },
			kotlin = { "ktlint", "injected" },
			-- NOTE: ltex doesn't support formatting
			latex = { "latexindex", "injected" },
			lua = { "stylua" },
			markdown = { "markdownlint-cli2", "injected" },
			python = { "usort", "ruff_format", "injected" },
			-- rust = { "rustfmt", "injected" },
			sh = { "shellharden", "shfmt" },
			sql = { "sqlfluff" },
			toml = { "taplo" },
			typst = { "typstfmt", "injected" },
		},
	},
	init = function()
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}
