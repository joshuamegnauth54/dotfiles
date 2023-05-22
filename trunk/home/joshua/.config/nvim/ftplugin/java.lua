local jdtls_path = "/usr/share/java/jdtls/"
local jdtls_plugins = jdtls_path .. "plugins/"
local equinox = "org.eclipse.equinox.launcher.jar"

-- From nvim-jdtls repository
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.fn.expand("~/Repos/Java/") .. project_name

-- Equinox launcher
local grep_equinox = io.popen("rg -g '*equinox.launcher_*.jar' --files " .. jdtls_plugins)
local equinox_path = jdtls_plugins .. equinox
if grep_equinox then
	local result = grep_equinox:read("*a")
	if result and result ~= "" then
		equinox_path = result
	else
		vim.notify("[nvim-jtls setup]: Unable to find: " .. equinox, vim.log.levels.WARN)
	end
else
	vim.notify("[nvim-jdtls setup]: Is ripgrep (`rg`) installed?", vim.log.levels.WARN)
end

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
		"-Xmx1g",
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
