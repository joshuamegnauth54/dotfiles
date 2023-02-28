-- Key bindings

local map = vim.api.nvim_set_keymap
local telebuiltin = require("telescope/builtin")

-- Use ; to run a command
map('n', ';', ":", {})

-- Toggle nvim-tree in normal mode
map('n', '`', ":NvimTreeToggle<cr>", {})

-- Toggle tagbar
map('n', 't', ":TagbarToggle<cr>", {})

-- Telescope keys
map('n', "<leader>ff", telebuiltin.find_files, {})
map('n', "<leader>fg", telebuiltin.live_grep, {})
map('n', "<leader>fb", telebuiltin.buffers, {})
map('n', "<leader>fh", telebuiltin.help_tags, {})
-- Symbols (emoji, math)
map('n', "<leader>fe", "<cmd>Telescope symbols<cr>", {})
-- Search through tabs
map('n', "<leader>ft", "<cmd>Telescope telescope-tabs list_tabs<cr>", {})
map('n', "<leader>ftb", "<cmd>Telescope telescope-tabs go_to_previous<cr>", {})
-- Search through headings; o for octothorpe
map('n', "<leader>fo", "<cmd>Telescope heading<cr>")
-- View buffer undo tree
map('n', "<leader>fu", "<cmd>Telescope undo<cr>", {})
