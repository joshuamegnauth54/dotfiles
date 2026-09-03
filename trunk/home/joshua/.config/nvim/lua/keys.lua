-- Key bindings
-- Many of my bindings are specified using lazy.nvim itself

-- https://neovim.io/doc/user/lua.html#vim.keymap.set()
local map = vim.keymap.set

-- Use ; to run a command
map("n", ";", ":", {})

-- Buffer movement
-- No more ;bn spam!
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch buffer" })

-- Extensions. Might fold into Lazy's configs
-- Open the current file's directory with Neovim's builtin dir plugin
-- (unreleased as of Neovim 0.12; requires nightly). Netrw is disabled,
-- so this is a no-op until the dir plugin ships in stable.
map("n", "`", "<cmd>edit %:h<cr>", {})
