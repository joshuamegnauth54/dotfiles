-- Key bindings
-- Many of my bindings are specified using lazy.nvim itself

-- https://neovim.io/doc/user/lua.html#vim.keymap.set()
local map = vim.keymap.set

-- Use ; to run a command
map("n", ";", ":", {})

-- Toggle nvim-tree in normal mode
map("n", "`", "<cmd>NvimTreeToggle<cr>", {})

-- Toggle tagbar
map("n", "t", "<cmd>TagbarToggle<cr>", {})
