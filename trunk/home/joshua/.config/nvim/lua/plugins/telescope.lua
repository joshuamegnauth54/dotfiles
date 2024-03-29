-- Configs for telescope.nvim

local function telescope_keys(builtin, opts)
	opts = opts or {}
	return function()
		require("telescope/builtin")[builtin](opts)
	end
end

local function telescope_ext(ext, func, opts)
	func = func or ext
	opts = opts or {}
	return function()
		require("telescope").extensions[ext][func](opts)
	end
end

local function telescope_trouble()
	-- I'm not sure why this needs to be loaded
	require("telescope.actions")
	local trouble = require("trouble.providers.telescope")
	trouble.open_with_trouble()
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
			{ "<leader>fs", telescope_keys("lsp_references"), desc = "LSP references" },
			{ "<leader>fss", telescope_keys("lsp_document_symbols", symbols), desc = "LSP document symbols" },
			{ "<leader>fsS", telescope_keys("lsp_workplace_symbols", symbols), desc = "LSP workspace symbols" },
			{ "<leader>fm", telescope_keys("marks"), desc = "Search marks" },
			{
				"<leader>fn",
				function()
					require("telescope").extensions.notify.notify()
				end,
				desc = "Notifications",
			},
			{ "<leader>sp", telescope_keys("spell_suggest"), desc = "Spelling" },
			{ "<leader>/", telescope_keys("current_buffer_fuzzy_find"), desc = "Buffer fuzzy find" },
		},
		cmd = "Telescope",
		config = function()
			require("telescope").setup({
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
				"heading",
				"noice",
				"notify",
				"ui-select",
				"undo",
			}

			local tele = require("telescope")
			for _, ext in pairs(extensions) do
				tele.load_extension(ext)
			end
		end,
	},
	-- Search for emoji and other symbols with Telescope
	{
		"nvim-telescope/telescope-symbols.nvim",
		-- cmd = "Telescope",
		keys = { { "<leader>fe", telescope_keys("symbols"), desc = "List symbols (emoji)" } },
		dependencies = { "nvim-telescope/telescope.nvim" },
		-- I'm not sure why the plugin doesn't do this itself
		build = "git clone https://github.com/nvim-telescope/telescope-symbols.nvim /tmp/lazy/telescope-symbols && cp -r /tmp/lazy/telescope-symbols/data ~/.config/nvim",
	},
	-- Search through tabs with telescope
	{
		"LukasPietzschmann/telescope-tabs",
		-- cmd = "Telescope",
		keys = {
			-- Search through tabs
			{
				"<leader>ft",
				function()
					require("telescope-tabs").list_tabs()
				end,
				desc = "List tabs",
			},
			{
				"<leader>ftt",
				function()
					require("telescope-tabs").go_to_previous()
				end,
				desc = "Go to previous tab",
			},
		},
		dependencies = { "nvim-telescope/telescope.nvim" },
	},
	-- Search through headings in LaTeX and Markdown
	{
		"crispgm/telescope-heading.nvim",
		-- cmd = "Telescope",
		keys = {
			-- Search through headings; o for octothorpe
			{ "<leader>fo", telescope_ext("heading"), desc = "Search through document headings" },
		},
		dependencies = { "nvim-telescope/telescope.nvim" },
	},
	-- View buffer undo tree
	{
		"debugloop/telescope-undo.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		keys = {
			{ "<leader>fu", telescope_ext("undo"), desc = "View undo tree" },
		},
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
