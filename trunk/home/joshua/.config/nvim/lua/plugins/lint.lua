-- https://github.com/mfussenegger/nvim-lint

-- Lint auto command
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		require("lint").try_lint()
	end,
})

return {
	{
		"mfussenegger/nvim-lint",
		config = function()
			require("lint").linters_by_ft = {
				c = { "clangtidy", "cppcheck", "flawfinder" },
				cmake = { "cmakelint" },
				cpp = { "clazy", "clangtidy", "cppcheck", "flawfinder" },
				dockerfile = { "hadolint" },
				fish = { "fish" },
				kotlin = { "ktlint" },
				python = { "bandit" },
				rst = { "rstcheck" },
				sh = { "shellcheck", "dotenv_linter" },
				sql = { "sqlfluff" },
				yaml = { "actionlint" },
			}
		end,
	},
}
