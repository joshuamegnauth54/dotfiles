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
		config = function()
			-- Mappings.
			-- Copied from the lspconfig repo with minor edits
			-- NOTE: Commented out mappings are handled by lspsaga.
			local key_opts = { noremap = true, silent = true }
			vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, key_opts)
			-- vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
			-- vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
			vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, key_opts)

			-- Use an autocmd for LspAttach to bind keys after an LSP attaches
			-- to the current buffer
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					-- Enable completion triggered by <c-x><c-o>
					vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

					-- Buffer local mappings.
					-- See `:help vim.lsp.*` for documentation on any of the below functions
					local opts = { buffer = ev.buf }
					-- vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
					-- vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					-- vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
					vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
					vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
					vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
					vim.keymap.set("n", "<space>wl", function()
						print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					end, opts)
					vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
					-- Rename symbols across workspace
					-- vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
					-- vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
					-- NOTE: Deferring to conform.nvim which automagically uses LSP formatting
					-- vim.keymap.set("n", "<leader>f", function()
					-- 	-- WARNING: https://github.com/mhartington/formatter.nvim/issues/260
					-- 	-- Hopefully this is fixed
					-- 	local formatter_ft = require("formatter.config").values.filetype
					-- 	if formatter_ft[vim.bo.filetype] ~= nil then
					-- 		vim.cmd.Format()
					-- 	else
					-- 		vim.lsp.buf.format({ async = true })
					-- 	end
					-- end, opts)
				end,
			})

			-- XXX: This is way too ugly and annoying to set up properly.
			-- vim.lsp.inlay_hint.enable(true)

			-- Rust, C, Haskell, base TypeScript, Deno, and Go are managed by other plugins below
			-- CSS, HTML, and JSON are set up below for snippet support
			local default_lsps = {
				-- https://github.com/angular/vscode-ng-language-service
				"angularls",
				-- https://github.com/ansible/ansible-language-server
				"ansiblels",
				-- https://github.com/bergercookie/asm-lsp
				"asm_lsp",
				-- https://github.com/Freed-Wu/autotools-language-server
				"autotools_ls",
				-- https://github.com/mads-hartmann/bash-language-server
				"bashls",
				-- Convenient and fast tools for TypeScript including an LSP
				-- https://github.com/biomejs/biome
				"biome",
				-- https://github.com/facebook/buck2
				"buf_ls",
				-- https://bzl.io/
				"bzl",
				-- https://github.com/regen100/cmake-language-server
				"cmake",
				"cssls",
				"denols",
				-- https://github.com/microsoft/compose-language-service
				"docker_compose_language_service",
				-- https://github.com/rcjsuen/dockerfile-language-server-nodejs
				"dockerls",
				-- https://github.com/influxdata/flux-lsp
				-- Influx's query language
				"flux_lsp",
				-- https://github.com/godotengine/godot
				"gdscript",
				-- https://github.com/svenstaro/glsl-language-server
				"glslls",
				-- https://github.com/golang/tools/tree/master/gopls
				-- NOTE: go.nvim doesn't seem to work unless I load gopls here
				"gopls",
				-- https://github.com/microsoft/vscode-gradle
				"gradle_ls",
				-- https://github.com/graphql/graphiql/tree/main/packages/graphql-language-service-cli
				"graphql",
				-- https://github.com/haskell/haskell-language-server
				-- "hls",
				"html",
				-- https://github.com/ThePrimeagen/htmx-lsp
				"htmx",
				"just",
				-- https://github.com/fwcd/kotlin-language-server
				-- NOTE: Using ktlint via nvim-lint
				-- "kotlin_language_server",
				-- NOTE: Using markdownlint
				-- https://github.com/artempyanykh/marksman
				-- "marksman",
				-- https://github.com/llvm/llvm-project
				"mlir_lsp_server",
				"mlir_pdll_lsp_server",
				-- https://github.com/neomutt/mutt-language-server
				"mutt_ls",
				-- https://github.com/nushell/nushell
				"nushell",
				-- https://github.com/Freed-Wu/pkgbuild-language-server
				"pkgbuild_language_server",
                -- https://doc.qt.io/qt-6/qtqml-tooling-qmlls.html
                "qmlls",
				-- https://github.com/charliermarsh/ruff
				"ruff",
				-- https://github.com/slint-ui/slint
				"slint_lsp",
				-- https://github.com/joe-re/sql-language-server
				-- Has per project configs
				-- NOTE: Using sqlfluff via nvim-lint
				-- "sqlls",
				-- Svelte language server
				-- https://github.com/sveltejs/language-tools/tree/master/packages/language-server,
				"svelte",
				"taplo",
				-- Tailwind CSS
				-- https://github.com/tailwindlabs/tailwindcss-intellisense
				"tailwindcss",
				-- https://github.com/Myriad-Dreamin/tinymist
				-- "tinymist",
				"ty",
				-- Typos LSP
				-- https://github.com/crate-ci/typos
				"typos_lsp",
				-- Vue
				-- https://github.com/vuejs/vetur/tree/master/server
				"vue_ls",
				-- WGSL
				-- https://github.com/wgsl-analyzer/wgsl-analyzer
				"wgsl_analyzer",
				-- YAML
				-- https://github.com/redhat-developer/yaml-language-server
				"yamlls",
				-- Zig
				-- https://github.com/zigtools/zls
				"zls",
			}

			-- Variables to pass to LSP configs
			-- https://github.com/neovim/nvim-lspconfig/wiki/Snippets
			local lsp_flags = {}
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			capabilities.textDocument.completion.completionItem.snippetSupport = true

			for _, lsp in pairs(default_lsps) do
				vim.lsp.enable(lsp)
				vim.lsp.config(lsp, {
					capabilities = capabilities,
					flags = lsp_flags,
				})
			end

			-- Special configs

			-- https://github.com/hrsh7th/vscode-langservers-extracted
			-- CSS, HTML, and JSON require a snippet engine
			--Enable (broadcasting) snippet capability for completion

			-- https://clangd.llvm.org/installation.html
			-- NOTE: clangd-extensions' instructions say to set up clangd here too
			vim.lsp.enable("clangd")
			vim.lsp.config("clangd", {
				capabilities = capabilities,
				on_attach = function()
					require("clangd_extensions.inlay_hints").setup_autocmd()
					require("clangd_extensions.inlay_hints").set_inlay_hints()
				end,
			})

			-- JSON
			vim.lsp.enable("jsonls")
			vim.lsp.config("jsonls", {
				capabilities = capabilities,
				settings = {
					json = {
						-- Use schemastore (see below)
						schemas = require("schemastore").json.schemas(),
						validate = { enable = true },
					},
				},
			})

			-- LaTeX
			-- https://github.com/latex-lsp/texlab
			vim.lsp.enable("texlab")
			vim.lsp.config("texlab", {
				capabilities = capabilities,
				settings = {
					texlab = {
						chktex = {
							onEdit = true,
						},
					},
				},
			})

			-- Lua
			vim.lsp.enable("lua_ls")
			vim.lsp.config("lua_ls", {
				capabilities = capabilities,
				settings = {
					Lua = {
						color = {
							mode = "SemanticEnhanced",
						},
						-- Using stylua instead
						format = {
							enable = false,
						},
						hint = {
							enable = true,
							paramType = true,
							paramName = "All",
							setType = true,
						},
						telemetry = {
							enable = false,
						},
					},
				},
			})

			-- Typst
			vim.lsp.enable("tinymist")
			vim.lsp.config("tinymist", {
				settings = {
					formatterMode = "typstyle",
				},
			})
		end,
	},
	-- More pleasant Rust experience
	{
		"mrcjkb/rustaceanvim",
		opts = {
			tools = {
				-- inlay_hints = {
				-- 	highlight = "Special",
				-- },
			},
			server = {
				on_attach = function(_, bufnr)
					-- Hover actions
					vim.keymap.set("n", "<C-space>", function()
						vim.cmd.RustLsp({ "hover", "actions" })
					end, { buffer = bufnr })
					-- Open docs.rs for item
					vim.keymap.set("n", "<Leader>a", function()
						vim.cmd.RustLsp({ "openDocs" })
					end, { buffer = bufnr })
				end,
				default_settings = {
					capabilities = require("cmp_nvim_lsp").default_capabilities(),
					["rust-analyzer"] = {
						cargo = {
							allTargets = true,
							allFeatures = true,
							features = "all",
							loadOutDirsFromCheck = true,
							buildScripts = {
								enable = true,
							},
						},
						checkOnSave = true,
						diagnostics = {
							enable = true,
							styleLints = {
								enable = true,
							},
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
		config = function(_, opts)
			vim.g.rustaceanvim = vim.tbl_extend("keep", vim.g.rustaceanvim or {}, opts or {})
		end,
		-- lazy = true,
		event = "BufRead Cargo.toml",
		ft = { "rust" },
	},
	-- Better cargo.toml integration
	{
		"saecki/crates.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = true,
		opts = {
			completion = {
				cmp = {
					enabled = true,
				},
				crates = {
					enabled = true,
				},
			},
			lsp = {
				enabled = true,
				actions = true,
				completion = true,
				hover = true,
			},
		},
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
	},
	-- https://schemastore.org/ support
	{
		"b0o/SchemaStore.nvim",
		dependencies = { "neovim/nvim-lspconfig" },
		ft = { "json" },
	},
	-- Better Java support
	-- I'm not setting up most of it though. Oh well
	{
		"mfussenegger/nvim-jdtls",
		dependencies = { "neovim/nvim-lspconfig" },
		ft = { "java" },
	},
	-- Tools for neovim plugin development
	{
		"folke/lazydev.nvim",
		ft = { "lua" },
	},
	-- https://github.com/mrcjkb/haskell-tools.nvim
	{
		"mrcjkb/haskell-tools.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
		config = function()
			require("telescope").load_extension("ht")
		end,
	},
}
