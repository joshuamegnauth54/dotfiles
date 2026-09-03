-- Language server provider configs.

-- Mappings.
-- Copied from the lspconfig repo with minor edits.
-- Diagnostic.
vim.keymap.set("n", "[e", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
vim.keymap.set("n", "]e", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
vim.keymap.set("n", "z", vim.diagnostic.open_float, { desc = "Show diagnostic" })
vim.keymap.set("n", "<leader>xx", vim.diagnostic.setqflist, { desc = "Send diagnostics to quickfix" })
vim.keymap.set("n", "<leader>xc", "<cmd>cclose<cr>", { desc = "Close quickfix" })

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Use an autocmd for LspAttach to bind keys after an LSP attaches
		-- to the current buffer.
		local opts = { buffer = ev.buf }

		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
		vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
		vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
	end,
})

-- Rust, C, Haskell, base TypeScript, Deno, and Go are managed elsewhere.
local default_lsps = {
	"angularls",
	"ansiblels",
	"asm_lsp",
	"autotools_ls",
	"bashls",
	"biome",
	"buf_ls",
	"bzl",
	"clangd",
	"cmake",
	"cssls",
	"denols",
	"docker_compose_language_service",
	"dockerls",
	"flux_lsp",
	"gdscript",
	"glslls",
	"gopls",
	"gradle_ls",
	"graphql",
	"hls",
	"html",
	"htmx",
	"jdtls",
	"just",
	"kotlin_language_server",
	"mlir_lsp_server",
	"mlir_pdll_lsp_server",
	"mutt_ls",
	"nushell",
	"pkgbuild_language_server",
	"qmlls",
	"ruff",
	"slint_lsp",
	"svelte",
	"taplo",
	"tailwindcss",
	"ty",
	"typos_lsp",
	"vue_ls",
	"wgsl_analyzer",
	"yamlls",
	"zls",
}

for _, lsp in ipairs(default_lsps) do
	vim.lsp.enable(lsp)
end

-- Special configs.
-- JSON.
vim.lsp.enable("jsonls")
vim.lsp.config("jsonls", {
	settings = {
		json = {
			-- Use schemastore (see below).
			schemas = require("schemastore").json.schemas(),
			validate = { enable = true },
		},
	},
})

-- LaTeX.
-- https://github.com/latex-lsp/texlab
vim.lsp.enable("texlab")
vim.lsp.config("texlab", {
	settings = {
		texlab = {
			chktex = {
				onEdit = true,
			},
		},
	},
})

-- Lua.
vim.lsp.enable("lua_ls")
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			color = {
				mode = "SemanticEnhanced",
			},
			format = {
				-- Using stylua instead.
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

-- Typst.
vim.lsp.enable("tinymist")
vim.lsp.config("tinymist", {
	settings = {
		formatterMode = "typstyle",
	},
})

-- YAML.
vim.lsp.config("yamlls", {
	settings = {
		yaml = {
			SchemaStore = {
				enable = false,
				url = "",
			},
			schemas = require("schemastore").yaml.schemas(),
		},
	},
})

-- More pleasant Rust experience.
vim.g.rustaceanvim = {
	tools = {},
	server = {
		on_attach = function(_, bufnr)
			vim.keymap.set("n", "<C-space>", function()
				vim.cmd.RustLsp({ "hover", "actions" })
			end, { buffer = bufnr, desc = "Rust hover actions" })
			vim.keymap.set("n", "<Leader>a", function()
				vim.cmd.RustLsp({ "openDocs" })
			end, { buffer = bufnr, desc = "Open docs.rs" })
		end,
		default_settings = {
			["rust-analyzer"] = {
				cargo = {
					allTargets = true,
					features = "all",
					buildScripts = {
						enable = true,
					},
				},
				procMacro = {
					enable = true,
				},
				checkOnSave = true,
				diagnostics = {
					enable = true,
					styleLints = {
						enable = true,
					},
				},
				check = {
					command = "clippy",
				},
				hover = {
					memoryLayout = {
						niches = true,
					},
				},
				inlayHints = {
					closureReturnTypeHints = {
						enable = "always",
					},
					lifetimeElisionHints = {
						enable = "skip_trivial",
					},
					closureCaptureHints = {
						enable = true,
					},
					discriminantHints = {
						enable = "fieldless",
					},
					implicitDrops = {
						enable = true,
					},
				},
				lru = {
					capacity = 256,
				},
			},
		},
	},
}

-- Better cargo.toml integration.
require("crates").setup({
	completion = {
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
})

-- https://schemastore.org/ support is configured above.
-- Tools for Neovim plugin development are loaded by vim.pack.
vim.keymap.set("n", "<leader>cv", function()
	require("crates").show_versions_popup({})
end, { desc = "Show crate versions" })
vim.keymap.set("n", "<leader>cf", function()
	require("crates").show_features_popup({})
end, { desc = "Show crate features" })
vim.keymap.set("n", "<leader>cd", function()
	require("crates").show_dependencies_popup({})
end, { desc = "Show crate dependencies" })
