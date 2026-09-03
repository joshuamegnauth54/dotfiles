-- https://github.com/mfussenegger/nvim-lint

-- Lint auto command
local lint = require("lint")
lint.linters_by_ft = {
	c = { "clangtidy", "cppcheck", "flawfinder" },
	cmake = { "cmakelint" },
	cpp = { "clazy", "clangtidy", "cppcheck", "flawfinder" },
	dockerfile = { "hadolint" },
	fish = { "fish" },
	go = { "golangcilint" },
	kotlin = { "ktlint" },
	lua = { "selene" },
	python = { "bandit" },
	rst = { "rstcheck" },
	sh = { "shellcheck", "dotenv_linter" },
	sql = { "sqlfluff" },
	yaml = { "actionlint" },
}

vim.api.nvim_create_autocmd("BufWritePost", {
	callback = function()
		lint.try_lint()
	end,
})
