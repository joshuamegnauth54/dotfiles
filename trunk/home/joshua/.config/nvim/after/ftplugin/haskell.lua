local ht = require("haskell-tools")

-- Hoogle search for the signature under the cursor
vim.keymap.set("n", "<leader>hs", ht.hoogle.hoogle_signature)
-- Evaluate all code snippets
vim.keymap.set("n", "<leader>ea", ht.lsp.buf_eval_all)

vim.g.haskell_tools = {
	hls = {
		capabilities = require("cmp_nvim_lsp").default_capabilities(),
	},
}
