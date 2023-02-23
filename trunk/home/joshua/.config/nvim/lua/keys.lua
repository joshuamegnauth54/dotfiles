-- Key bindings

local map = vim.api.nvim_set_keymap
local telebuiltin = require("telescope/builtin")

-- Use ; to run a command
map('n', ';', ":", {})

-- Toggle nvim-tree in normal mode
map('n', '`', ":NvimTreeToggle<CR>", {})

-- Toggle tagbar
map('n', 't', ":TagbarToggle<CR>", {})

-- Telescope keys
vim.keymap.set('n', '<leader>ff', telebuiltin.find_files, {})
vim.keymap.set('n', '<leader>fg', telebuiltin.live_grep, {})
vim.keymap.set('n', '<leader>fb', telebuiltin.buffers, {})
vim.keymap.set('n', '<leader>fh', telebuiltin.help_tags, {})
