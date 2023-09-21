-- https://github.com/mfussenegger/nvim-lint

-- Lint auto command
vim.api.nvim_create_autocmd({ "TextChanged" }, {
	callback = function()
		require("lint").try_lint()
	end,
})

return {
	{
		"mfussenegger/nvim-lint",
		lazy = true,
		config = function()
			require("lint").linters_by_ft = {
				c = { "clangtidy", "cppcheck", "flawfinder" },
				cmake = { "cmakelint" },
				cpp = { "clazy", "clangtidy", "cppcheck", "flawfinder" },
				dockerfile = { "hadolint" },
				json = { "cfn_lint", "cfn_nag" },
				kotlin = { "ktlint" },
				python = { "bandit" },
				rst = { "rstcheck" },
				sh = { "shellcheck" }, --, "dotenv_linter"},
				sql = { "sqlfluff" },
				yaml = { "actionlint", "cfn_lint", "cfn_nag" },
			}

			-- require("lint").linters = {
			-- 	dotenv_linter = {},
			-- }
		end,
	},
}
