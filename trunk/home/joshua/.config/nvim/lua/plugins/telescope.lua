-- Configs for telescope.nvim

local function telescope_keys(builtin, opts)
	opts = opts or {}
	return function()
		require("telescope/builtin")[builtin](opts)
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

			-- Telescope extension keys
			-- DAP telescope
			-- map('n', )
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
				"notify",
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
		keys = { { "<leader>fe", "<cmd>Telescope symbols<cr>" } },
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
			{ "<leader>ft", "<cmd>Telescope telescope-tabs list_tabs<cr>" },
			{ "<leader>ftb", "<cmd>Telescope telescope-tabs go_to_previous<cr>" },
		},
		dependencies = { "nvim-telescope/telescope.nvim" },
	},
	-- Search through headings in LaTeX and Markdown
	{
		"crispgm/telescope-heading.nvim",
		-- cmd = "Telescope",
		keys = {
			-- Search through headings; o for octothorpe
			{ "<leader>fo", "<cmd>Telescope heading<cr>" },
		},
		dependencies = { "nvim-telescope/telescope.nvim" },
	},
	-- View buffer undo tree
	{
		"debugloop/telescope-undo.nvim",
		-- cmd = "Telescope",
		keys = {
			{ "<leader>fu", "<cmd>Telescope undo<cr>" },
		},
		dependencies = { "nvim-telescope/telescope.nvim" },
	},
	-- DAP integration for telescope
	{
		"nvim-telescope/telescope-dap.nvim",
		cmd = "Telescope",
		dependencies = { "mfussenegger/nvim-dap", "nvim-telescope/telescope.nvim" },
	},
}
