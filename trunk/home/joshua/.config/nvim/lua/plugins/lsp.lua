-- Language server provider configs

local function crates_keys(func_str)
	return function()
		require("crates")[func_str]({})
	end
end

return {
	-- Quick language server configs
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			-- Mason is a package manager for LSPs, DAPs, linters, and formatters
			-- https://github.com/williamboman/mason.nvim
			{
				"williamboman/mason.nvim",
				config = true,
			},
			{
				"williamboman/mason-lspconfig.nvim",
				config = true,
			},
		},
		config = function()
			-- Mappings.
			-- Copied from the lspconfig repo with minor edits
			local opts = { noremap = true, silent = true }
			vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
			vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

			-- Use an on_attach function to only map the following keys
			-- after the language server attaches to the current buffer
			local on_attach = function(client, bufnr)
				-- Enable completion triggered by <c-x><c-o>
				vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

				-- Mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local bufopts = { noremap = true, silent = true, buffer = bufnr }
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
				vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
				vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
				vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
				vim.keymap.set("n", "<space>wl", function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, bufopts)
				vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
				vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
				vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
				vim.keymap.set("n", "<space>f", function()
					vim.lsp.buf.format({ async = true })
				end, bufopts)
			end

			-- Rust, C, base TypeScript, and Deno are managed by other plugins below
			-- CSS, HTML, and JSON are set up below for snippet support
			local lspconfig = require("lspconfig")
			local default_lsps = {
				-- https://github.com/angular/vscode-ng-language-service
				"angularls",
				-- https://github.com/bergercookie/asm-lsp
				"asm_lsp",
				-- https://github.com/Beaglefoot/awk-language-server/
				"awk_ls",
				-- https://github.com/mads-hartmann/bash-language-server
				"bashls",
				-- https://github.com/regen100/cmake-language-server
				"cmake",
				-- https://github.com/razzmatazz/csharp-language-server
				"csharp_ls",
				-- https://github.com/antonk52/cssmodules-language-server
				"cssmodules_ls",
				-- https://github.com/microsoft/compose-language-service
				"docker_compose_language_service",
				-- https://github.com/rcjsuen/dockerfile-language-server-nodejs
				"dockerls",
				-- https://github.com/nikeee/dot-language-server
				-- Graphviz
				"dotls",
				-- https://github.com/influxdata/flux-lsp
				-- Influx's query language
				"flux_lsp",
				-- https://github.com/svenstaro/glsl-language-server
				"glslls",
				-- https://github.com/golang/tools/tree/master/gopls
				"gopls",
				-- https://github.com/microsoft/vscode-gradle
				"gradle_ls",
				-- https://github.com/graphql/graphiql/tree/main/packages/graphql-language-service-cli
				"graphql",
				-- https://github.com/haskell/haskell-language-server
				"hls",
				-- https://github.com/fwcd/kotlin-language-server
				"kotlin_language_server",
				-- https://github.com/llvm/llvm-project
				"mlir_lsp_server",
				"mlir_pdll_lsp_server",
				-- I'm using this in conjunction with ruff.
				-- Pyright = type checker
				-- https://github.com/microsoft/pyright
				"pyright",
				-- Convenient and fast tools for TypeScript including an LSP
				-- https://github.com/rome/tools
				"rome",
				-- https://github.com/charliermarsh/ruff-lsp
				-- Python
				"ruff_lsp",
				-- https://github.com/joe-re/sql-language-server
				-- Has per project configs
				"sqlls",
				-- Svelte language server
				-- https://github.com/sveltejs/language-tools/tree/master/packages/language-server,
				"svelte",
				-- Tailwind CSS
				-- https://github.com/tailwindlabs/tailwindcss-intellisense
				"tailwindcss",
				-- Vue
				-- https://github.com/vuejs/vetur/tree/master/server
				"vuels",
				-- WGSL
				-- https://github.com/wgsl-analyzer/wgsl-analyzer
				"wgsl_analyzer",
				-- YAML
				-- https://github.com/redhat-developer/yaml-language-server
				"yamlls",
			}

			-- Variables to pass to LSP configs
			-- https://github.com/neovim/nvim-lspconfig/wiki/Snippets
			local lsp_flags = {}
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			for _, lsp in pairs(default_lsps) do
				lspconfig[lsp].setup({
					capabilities = capabilities,
					on_attach = on_attach,
					flags = lsp_flags,
				})
			end

			-- Special configs

			-- https://github.com/hrsh7th/vscode-langservers-extracted
			-- CSS, HTML, and JSON require a snippet engine
			--Enable (broadcasting) snippet capability for completion
			local html_cap = vim.lsp.protocol.make_client_capabilities()
			html_cap.textDocument.completion.completionItem.snippetSupport = true

			lspconfig["html"].setup({
				capabilities = html_cap,
			})

			-- Snippet support for CSS completion
			lspconfig["cssls"].setup({
				capabilities = html_cap,
			})

			lspconfig["jsonls"].setup({
				capabilities = html_cap,
				settings = {
					json = {
						-- Use schemastore (see below)
						schemas = require("schemastore").json.schemas(),
						validate = { enable = true },
					},
				},
			})
			-- LanguageTool support for LaTeX, Markdown, and others
			lspconfig["ltex"].setup({
				capabilities = capabilities,
				settings = {
					ltex = {
						language = "en_US",
						ltex_ls = {
							path = "/usr/bin/ltex-ls",
						},
						java = {
							path = "/usr/bin/java",
							maximumHeapSize = 1024,
						},
						sentenceCacheSize = 4096,
					},
				},
			})

			-- Lua
			lspconfig["lua_ls"].setup({
				capabilities = capabilities,
				settings = {
					Lua = {
						telemetry = {
							enable = false,
						},
					},
				},
			})

			-- LaTeX
			-- https://github.com/latex-lsp/texlab
			lspconfig["texlab"].setup({
				capabilities = capabilities,
				settings = {
					texlab = {
						chktex = {
							onEdit = true,
						},
					},
				},
			})
		end,
	},
	-- More pleasant Rust experience
	{
		"simrat39/rust-tools.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
			"nvim-lua/plenary.nvim",
		},
		opts = {
			tools = {
				inlay_hints = {
					highlight = "Special",
				},
			},
			server = {
				on_attach = function(_, bufnr)
					-- Hover actions
					vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
					-- Code action groups
					vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
				end,
				settings = {
					["rust-analyzer"] = {
						cargo = {
							features = "all",
						},
						check = {
							-- Check all targets and tests
							allTargets = true,
							-- Use clippy instead of the default "check"
							command = "clippy",
							-- Check all features instead of eliding feature gated code
							-- Without this, code that is locked behind a feature isn't checked on save which is annoying
							-- Defaults to whatever `rust-analyzer.cargo.features` is
							features = "all",
						},
						inlayHints = {
							closureReturnTypeHints = {
								enable = "always",
							},
							-- This is too noisy
							-- expressionAdjustmentHints = {
							-- enable = "reborrow",
							-- },
							lifetimeElisionHints = {
								enable = "skip_trivial",
							},
						},
						lru = {
							capacity = 256,
						},
					},
				},
			},
		},
		-- lazy = true,
		-- event = "BufRead *.rs",
		ft = { "rust" },
	},
	-- Better cargo.toml integration
	{
		"saecki/crates.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = true,
		-- lazy = true,
		event = "BufRead Cargo.toml",
		keys = {

			{ "<leader>cv", crates_keys("show_versions_popup") },
			{ "<leader>cf", crates_keys("show_features_popup") },
			{ "<leader>cd", crates_keys("show_dependencies_popup") },
			{ "<leader>cu", crates_keys("update_crate") },
			{ "<leader>cu", crates_keys("update_crates"), "v" },
			{ "<leader>ca", crates_keys("update_all_crates") },
			{ "<leader>cU", crates_keys("upgrade_crate") },
			{ "<leader>cU", crates_keys("upgrade_crates"), "v" },
			{ "<leader>cA", crates_keys("upgrade_all_crates") },
		},
	},
	-- Better clang
	{
		"p00f/clangd_extensions.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
		},
		ft = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
		opts = {
			extensions = {
				inlay_hints = {
					highlight = "Special",
				},
			},
		},
	},
	-- Better Deno
	-- This may cause problems if tsserver is enabled too
	-- I think I can use deno for everything though
	-- Default root pattern: deno.json, deno.jsonc
	{
		"sigmasd/deno-nvim",
		dependencies = { "neovim/nvim-lspconfig" },
		ft = {
			"javascript",
			"javascriptreact",
			"javascript.jsx",
			"typescript",
			"typescriptreact",
			"typescript.tsx",
		},
		opts = {
			server = {
				settings = {
					deno = {
						inlayHints = {
							parameterNames = {
								enabled = "all",
							},
							parameterTypes = {
								enabled = true,
							},
							variableTypes = {
								enabled = true,
							},
							functionLikeReturnTypes = {
								enabled = true,
							},
						},
					},
				},
			},
		},
	},
	-- https://schemastore.org/ support
	{
		"b0o/SchemaStore.nvim",
		ft = { "json" },
	},
	-- Better Java support
	-- I'm not setting up most of it though. Oh well
	{
		"mfussenegger/nvim-jdtls",
		ft = { "java" },
	},
}
