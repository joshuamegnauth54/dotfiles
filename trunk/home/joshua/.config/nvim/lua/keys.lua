-- Key bindings

-- https://neovim.io/doc/user/lua.html#vim.keymap.set()
local map = vim.keymap.set

-- Use ; to run a command
map('n', ';', ":", {})

-- Toggle nvim-tree in normal mode
map('n', '`', "<cmd>NvimTreeToggle<cr>", {})

-- Toggle tagbar
map('n', 't', "<cmd>TagbarToggle<cr>", {})

-- Telescope keys
local telebuiltin = require("telescope/builtin")
map('n', "<leader>ff", telebuiltin.find_files, {})
map('n', "<leader>fg", telebuiltin.live_grep, {})
map('n', "<leader>fb", telebuiltin.buffers, {})
map('n', "<leader>fh", telebuiltin.help_tags, {})
map('n', "<leader>fr", telebuiltin.lsp_references, {})
map('n', "<leader>fds", telebuiltin.lsp_document_symbols, {})

-- Telescope extension keys
-- Symbols (emoji, math)
map('n', "<leader>fe", "<cmd>Telescope symbols<cr>", {})
-- Search through tabs
map('n', "<leader>ft", "<cmd>Telescope telescope-tabs list_tabs<cr>", {})
map('n', "<leader>ftb", "<cmd>Telescope telescope-tabs go_to_previous<cr>", {})
-- Search through headings; o for octothorpe
map('n', "<leader>fo", "<cmd>Telescope heading<cr>", {})
-- View buffer undo tree
map('n', "<leader>fu", "<cmd>Telescope undo<cr>", {})
-- DAP telescope
-- map('n', )

-- Crates
local crates = require("crates")
map('n', '<leader>cv', crates.show_versions_popup, {})
map('n', '<leader>cf', crates.show_features_popup, {})
map('n', '<leader>cd', crates.show_dependencies_popup, {})
map('n', '<leader>cu', crates.update_crate, {})
map('v', '<leader>cu', crates.update_crates, {})
map('n', '<leader>ca', crates.update_all_crates, {})
map('n', '<leader>cU', crates.upgrade_crate, {})
map('v', '<leader>cU', crates.upgrade_crates, {})
map('n', '<leader>cA', crates.upgrade_all_crates, {})
