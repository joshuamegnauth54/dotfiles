-- Configs for telescope.nvim
-- Stolen from the lazy.nvim example config.

-- Fuzzy finder over lists.

local function telescope_keys(name, opts)
	return function()
		require("telescope.builtin")[name](opts)
	end
end

local function telescope_ext(ext, func, opts)
	func = func or ext
	opts = opts or {}
	return function()
		require("telescope").extensions[ext][func](opts)
	end
end

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

local telescope = require("telescope")
telescope.setup({
	extensions = {
		-- UI replacement for vim.ui.select.
		-- Faster fuzzy searching with native fzf.
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

-- Note: Not every extension must be loaded like this.
for _, extension in ipairs({ "dap", "fzf", "noice", "ui-select" }) do
	telescope.load_extension(extension)
end

vim.keymap.set("n", "<leader>ff", telescope_keys("find_files"), { desc = "Find files in CWD" })
vim.keymap.set("n", "<leader>fg", telescope_keys("live_grep"), { desc = "Live grep" })
vim.keymap.set("n", "<leader>fs", telescope_keys("grep_string"), { desc = "Grep string" })
vim.keymap.set("n", "<leader>fb", telescope_keys("buffers"), { desc = "List open buffers" })
vim.keymap.set("n", "<leader>fh", telescope_keys("help_tags"), { desc = "List help tags" })
vim.keymap.set("n", "<leader>fr", telescope_keys("lsp_references"), { desc = "LSP references" })
vim.keymap.set("n", "<leader>fss", telescope_keys("lsp_document_symbols", symbols), {
	desc = "LSP document symbols",
})
vim.keymap.set("n", "<leader>fsS", telescope_keys("lsp_dynamic_workspace_symbols", symbols), {
	desc = "LSP workspace symbols",
})
vim.keymap.set("n", "<leader>fm", telescope_keys("marks"), { desc = "Search marks" })
vim.keymap.set("n", "<leader>fn", "<cmd>Noice history<cr>", { desc = "Message history" })
vim.keymap.set("n", "<leader>sp", telescope_keys("spell_suggest"), { desc = "Spelling" })
vim.keymap.set("n", "<leader>/", telescope_keys("current_buffer_fuzzy_find"), {
	desc = "Buffer fuzzy find",
})

-- DAP integration for telescope.
vim.keymap.set("n", "<leader>df", telescope_ext("dap", "list_breakpoints"), {
	desc = "List DAP breakpoints",
})
vim.keymap.set("n", "<leader>ds", telescope_ext("dap", "variables"), {
	desc = "List DAP variables",
})
