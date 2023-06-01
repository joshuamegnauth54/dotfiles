-- Code completion and snippets
return {
	-- https://github.com/hrsh7th/nvim-cmp
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		-- Extra or more advanced completion sources
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-omni",
			-- Function parameter completion
			-- NOTE: Using lspsaga instead for this now
			-- "hrsh7th/cmp-nvim-lsp-signature-help",
			-- dap-ui completion
			"https://github.com/rcarriga/cmp-dap",
			"David-Kunz/cmp-npm",
			-- Use snippy with cmp
			-- https://github.com/dcampos/nvim-snippy
			"dcampos/cmp-snippy",
			-- Add VS Code style pictograms
			"onsails/lspkind.nvim",
			-- Use more Treesitter nodes
			"ray-x/cmp-treesitter",
		},
		opts = function()
			local cmp = require("cmp")
			local cmp_table = {
				enabled = function()
					return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt" or require("cmp_dap").is_dap_buffer()
				end,
				snippet = {
					expand = function(args)
						require("snippy").expand_snippet(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					-- { name = "nvim_lsp_signature_help" },
					{ name = "nvim_lua", keyword_length = 2 },
					{ name = "snippy", keyword_length = 2 },
					{ name = "treesitter", keyword_length = 2 },
					{ name = "buffer" },
					{ name = "omni", keyword_length = 2 },
					{ name = "path" },
					{ name = "npm", keyword_length = 4 },
				}),
				formatting = {
					format = require("lspkind").cmp_format({}),
				},
			}

			-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})

			-- dap-ui completion
			cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
				sources = {
					{ name = "dap" },
				},
			})

			-- Autopairs
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

			vim.api.nvim_create_autocmd("BufRead", {
				group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
				pattern = "Cargo.toml",
				callback = function()
					cmp.setup.buffer({ sources = { { name = "crates" } } })
				end,
			})

			vim.api.nvim_create_autocmd("BufRead", {
				group = vim.api.nvim_create_augroup("CmpSourceText", { clear = true }),
				pattern = "*.md,*.txt",
				callback = function()
					cmp.setup.buffer({
						sources = {
							{ name = "emoji" },
							{ name = "nerdfont" },
						},
					})
				end,
			})

			return cmp_table
		end,
	},
	-- https://github.com/dcampos/nvim-snippy
	-- Minimalist snippets
	{
		"dcampos/nvim-snippy",
		opts = {
			mappings = {
				is = {
					["<Tab>"] = "expand_or_advance",
					["<S-Tab>"] = "previous",
				},
				nx = {
					["<leader>x"] = "cut_text",
				},
			},
		},
		dependencies = {
			{
				"honza/vim-snippets",
			},
			{
				"rafamadriz/friendly-snippets",
			},
		},
	},
	-- NPM package completions
	{
		"David-Kunz/cmp-npm",
		lazy = true,
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
}
