-- Configs for telescope.nvim

local function telescope_keys(name, opts)
	return function()
		require("telescope.builtin")[name](opts)
	end
end

keys = {
	{ "<leader>ff", telescope_keys("find_files"), desc = "Find files in CWD" },
	{ "<leader>fg", telescope_keys("live_grep"), desc = "Live grep" },
	{ "<leader>fs", telescope_keys("grep_string"), desc = "Grep string" },
	{ "<leader>fb", telescope_keys("buffers"), desc = "List open buffers" },
	{ "<leader>fh", telescope_keys("help_tags"), desc = "List help tags" },
	{ "<leader>fr", telescope_keys("lsp_references"), desc = "LSP references" },
	{ "<leader>fss", telescope_keys("lsp_document_symbols", symbols), desc = "LSP document symbols" },
	{ "<leader>fsS", telescope_keys("lsp_dynamic_workspace_symbols", symbols), desc = "LSP workspace symbols" },
	{ "<leader>fm", telescope_keys("marks"), desc = "Search marks" },
	{ "<leader>fn", "<cmd>Noice history<cr>", desc = "Message history" },
	{ "<leader>sp", telescope_keys("spell_suggest"), desc = "Spelling" },
	{ "<leader>/", telescope_keys("current_buffer_fuzzy_find"), desc = "Buffer fuzzy find" },
}

local function telescope_ext(ext, func, opts)
	func = func or ext
	opts = opts or {}
	return function()
		require("telescope").extensions[ext][func](opts)
	end
end

-- Stolen from the lazy.nvim example config
local symbols = {
	symbols = {
		"Class",
		"Function",
		"Method",
		"Constructor",
		"Interface",
		"Module",
		"Struct",
		"Trait",
		"Field",
		"Property",
	},
}

return {
	-- Fuzzy finder over lists
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-tree/nvim-web-devicons" },
			-- UI replacement for vim.ui.select
			{ "nvim-telescope/telescope-ui-select.nvim" },
			-- Faster fuzzy searching with native fzf
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
			},
		},
		keys = {
			{ "<leader>ff", telescope_keys("find_files"), desc = "Find files in CWD" },
			{ "<leader>fg", telescope_keys("live_grep"), desc = "Live grep" },
			{ "<leader>fs", telescope_keys("grep_string"), desc = "Grep string" },
			{ "<leader>fb", telescope_keys("buffers"), desc = "List open buffers" },
			{ "<leader>fh", telescope_keys("help_tags"), desc = "List help tags" },
			{ "<leader>fr", telescope_keys("lsp_references"), desc = "LSP references" },
			{ "<leader>fss", telescope_keys("lsp_document_symbols", symbols), desc = "LSP document symbols" },
			{ "<leader>fsS", telescope_keys("lsp_dynamic_workspace_symbols", symbols), desc = "LSP workspace symbols" },
			{ "<leader>fm", telescope_keys("marks"), desc = "Search marks" },
			{ "<leader>fn", "<cmd>Noice history<cr>", desc = "Message history" },
			{ "<leader>sp", telescope_keys("spell_suggest"), desc = "Spelling" },
			{ "<leader>/", telescope_keys("current_buffer_fuzzy_find"), desc = "Buffer fuzzy find" },
		},
		cmd = "Telescope",
		config = function()
			local telescope = require("telescope")
			telescope.setup({
				extensions = {
					heading = {
						treesitter = true,
					},
					undo = {
						-- This delta: https://github.com/dandavison/delta
						-- ...which I tend to have installed anyway
						use_delta = true,
					},
				},
			})

			-- Note: Not every extension must be loaded like this
			local extensions = {
				"dap",
				"fzf",
				"noice",
				"ui-select",
			}

			for _, ext in pairs(extensions) do
				telescope.load_extension(ext)
			end
		end,
	},
	-- DAP integration for telescope
	{
		"nvim-telescope/telescope-dap.nvim",
		keys = {
			{
				"<leader>df",
				telescope_ext("dap", "list_breakpoints"),
				desc = "List DAP breakpoints",
			},
			{
				"<leader>ds",
				telescope_ext("dap", "variables"),
				desc = "List DAP variables",
			},
		},
		dependencies = { "mfussenegger/nvim-dap", "nvim-telescope/telescope.nvim" },
	},
}
