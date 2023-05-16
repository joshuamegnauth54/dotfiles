-- Testing framework
-- https://github.com/nvim-neotest/neotest
return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			-- Test runners
			"MarkEmmons/neotest-deno",
			"nvim-neotest/neotest-go",
			"nvim-neotest/neotest-jest",
			"nvim-neotest/neotest-python",
			"rouge8/neotest-rust",
			"marilari88/neotest-vitest",
		},
		keys = {
			{
				"<leader>n",
				function()
					require("neotest").run.run()
				end,
				desc = "Run nearest test",
			},
			{
				"<leader>nn",
				function()
					require("neotest").run.run(vim.fn.expand("%"))
				end,
				desc = "Run tests (file)",
			},
			{
				"<leader>nd",
				function()
					require("neotest").run.run({ strategy = "dap" })
				end,
				desc = "Debug nearest test",
			},
			{
				"<leader>ns",
				function()
					require("neotest").run.stop()
				end,
				desc = "Stop running test",
			},
		},
		-- NOTE: Not using opts because the adapters need to be loaded with `require`
		-- which causes Lazy to raise an error.
		config = function()
			require("neotest").setup({
				adapters = {
					require("neotest-deno"),
					require("neotest-go"),
					require("neotest-jest"),
					require("neotest-python"),
					require("neotest-rust"),
					require("neotest-vitest"),
				},
			})
		end,
	},
}
