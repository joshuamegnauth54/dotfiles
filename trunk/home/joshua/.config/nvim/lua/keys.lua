-- Key bindings

local map = vim.api.nvim_set_keymap

-- Use ; to run a command
map('n', ';', ":", {})

-- Toggle nvim-tree in normal mode
map('n', 'n', [[:NvimTreeToggle]], {})
