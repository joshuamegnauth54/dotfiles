local jdtls_path = "/usr/share/java/jdtls/"
local jdtls_plugins = jdtls_path .. "plugins/"

-- From nvim-jdtls repository
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.fn.expand("~/.cache/Eclipse/") .. project_name

-- Equinox launcher
local equinox_path = vim.fn.glob(jdtls_plugins .. "org.eclipse.equinox.launcher_*.jar")

local config = {
	-- cmd = { "/usr/bin/jdtls" },
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
	cmd = {
		"java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xmx4g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		"-jar",
		equinox_path,
		"-configuration",
		jdtls_path .. "config_linux",
		"-data",
		workspace_dir,
	},
	root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" }),
	-- https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
	settings = {
		java = {
			signatureHelp = { enabled = true },
			format = {
				enabled = true,
				comments = { enabled = true },
				settings = {
					url = "https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml",
					profile = "GoogleStyle",
				},
			},
			codeGeneration = {
				useBlocks = true,
			},
			contentProvider = { preferred = "procyon-decompiler" },
			sources = {
				organizeImports = {
					starThreshold = 9999,
					staticStarThreshold = 9999,
				},
			},
		},
	},
	init_options = {
		bundles = {},
	},
	on_attach = function()
		require("jdtls").setup_dap({ hotcodereplace = "auto" })
	end,
}
require("jdtls").start_or_attach(config)
