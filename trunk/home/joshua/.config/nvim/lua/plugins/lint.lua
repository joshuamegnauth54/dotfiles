-- https://github.com/mfussenegger/nvim-lint

-- Lint auto command
vim.api.nvim_create_autocmd({ "InsertLeave" }, {
	callback = function()
		require("lint").try_lint()
	end,
})

return {
	{
		"mfussenegger/nvim-lint",
		lazy = true,
		opts = {
			linters = {
				-- dotenv_linter = {
				--     cmd = "dotenv-linter",
				-- }
			},
			linters_by_ft = {
				c = { "cppcheck", "flawfinder" },
				cmake = { "cmakelint" },
				cpp = { "cppcheck", "clazy", "flawfinder" },
				dockerfile = { "hadolint" },
				json = { "cfn_lint", "cfn_nag" },
				kotlin = { "ktlint" },
				python = { "bandit" },
				rst = { "rstcheck" },
				sh = { "shellcheck" }, --, "dotenv_linter"},
				sql = { "sqlfluff" },
				yaml = { "actionlint", "cfn_lint", "cfn_nag" },
			},
		},
	},
}
