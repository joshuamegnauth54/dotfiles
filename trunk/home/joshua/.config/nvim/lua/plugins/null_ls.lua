-- null-ls for cases where LSP support is incomplete or missing
-- https://github.com/jose-elias-alvarez/null-ls.nvim
return {
	{
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				log_level = "off",
				sources = {
					-- Diagnostics
					null_ls.builtins.diagnostics.actionlint,
					null_ls.builtins.diagnostics.cfn_lint,
					null_ls.builtins.diagnostics.checkmake,
					null_ls.builtins.diagnostics.dotenv_linter,
					null_ls.builtins.diagnostics.editorconfig_checker,
					null_ls.builtins.diagnostics.fish,
					null_ls.builtins.diagnostics.hadolint,
					null_ls.builtins.diagnostics.ktlint,
					-- NOTE: sqlfluff requires a config file per root
					null_ls.builtins.diagnostics.sqlfluff,
					-- Formatters
					null_ls.builtins.formatting.asmfmt,
					null_ls.builtins.formatting.beautysh,
					-- null_ls.builtins.formatting.black,
					null_ls.builtins.formatting.isort,
					null_ls.builtins.formatting.just,
					null_ls.builtins.formatting.ktlint,
					-- NOTE: ltex doesn't seem to support formatting
					null_ls.builtins.formatting.latexindent,
					-- null_ls.builtins.formatting.prettierd,
					null_ls.builtins.formatting.rome,
					-- NOTE: Formats using black
					null_ls.builtins.formatting.ruff,
					null_ls.builtins.formatting.shellharden,
					null_ls.builtins.formatting.shfmt,
					null_ls.builtins.formatting.sqlfluff,
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.taplo,
				},
			})
		end,
	},
}
