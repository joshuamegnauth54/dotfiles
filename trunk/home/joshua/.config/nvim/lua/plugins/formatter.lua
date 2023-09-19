-- https://github.com/mhartington/formatter.nvim/

return {
	{
		"mhartington/formatter.nvim",
		config = function()
			local formatter = require("formatter")

			formatter.setup({
				logging = false,
				-- NOTE: File types that aren't listed here are handled by an LSP
				filetype = {
					fish = {
						require("formatter.filetypes.fish").fishindent,
					},
					-- NOTE: graphql-lsp doesn't support formatting
					graphql = {
						require("formatter.filetypes.graphql").prettierd,
					},
					kotlin = {
						require("formatter.filetypes.kotlin").ktlint,
					},
					-- NOTE: ltex doesn't support formatting
					latex = {
						require("formatter.filetypes.latex").latexindent,
					},
					lua = {
						require("formatter.filetypes.lua").stylua,
					},
					python = {
						require("formatter.filetypes.python").isort,
                        require("formatter.filetypes.python").black
					},
					sh = {
						require("formatter.filetypes.sh").shfmt,
						function()
							return {
								exe = "shellharden",
								args = {
									"--transform",
								},
								stdin = true,
							}
						end,
					},
					sql = {
						function()
							return {
								exe = "sqlfluff",
								args = {
									"fix",
									"--disable-progress-bar",
									"-f",
									"-n",
									"-",
								},
								stdin = true,
							}
						end,
					},
					toml = {
						require("formatter.filetypes.toml").taplo,
					},
				},
			})
		end,
	},
}
