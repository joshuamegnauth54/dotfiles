-- Setup plugins

-- Native package manager:
-- https://neovim.io/doc/user/pack.html

local function github(repo)
	return "https://github.com/" .. repo
end

local plugins = {
	github("catppuccin/nvim"),
	github("nvim-tree/nvim-web-devicons"),
	github("nvim-lualine/lualine.nvim"),
	github("saghen/blink.indent"),
	github("lewis6991/gitsigns.nvim"),
	github("RRethy/vim-illuminate"),
	github("saghen/blink.pairs"),
	github("catgoose/nvim-colorizer.lua"),
	github("echasnovski/mini.comment"),
	github("kylechui/nvim-surround"),
	github("MunifTanjim/nui.nvim"),
	github("folke/noice.nvim"),
	github("folke/todo-comments.nvim"),
	github("nvim-lua/plenary.nvim"),
	github("xzbdmw/colorful-menu.nvim"),
	{
		src = github("saghen/blink.cmp"),
		version = vim.version.range("1.0"),
	},
	github("saghen/blink.lib"),
	github("rafamadriz/friendly-snippets"),
	github("mfussenegger/nvim-dap"),
	github("mfussenegger/nvim-dap-python"),
	github("rcarriga/nvim-dap-ui"),
	github("stevearc/conform.nvim"),
	github("mfussenegger/nvim-lint"),
	github("neovim/nvim-lspconfig"),
	github("mrcjkb/rustaceanvim"),
	github("saecki/crates.nvim"),
	github("b0o/SchemaStore.nvim"),
	github("folke/lazydev.nvim"),
	github("nvim-telescope/telescope.nvim"),
	github("nvim-telescope/telescope-ui-select.nvim"),
	github("nvim-telescope/telescope-fzf-native.nvim"),
	github("nvim-telescope/telescope-dap.nvim"),
	github("nvim-treesitter/nvim-treesitter"),
	github("nvim-treesitter/nvim-treesitter-context"),
	{
		src = github("nvim-treesitter/nvim-treesitter-textobjects"),
		version = "main",
	},
	github("windwp/nvim-ts-autotag"),
}

-- Wraps a shell build command, running it in the plugin's install path.
local function shell_build(command)
	return function(path)
		local result = vim.system({ "sh", "-c", command }, { cwd = path }):wait()
		if result.code ~= 0 then
			error(("build failed (exit code %s): %s"):format(result.code or "unknown", command))
		end
	end
end

-- Each entry is a function(path) run after that plugin is installed/updated.
local build_commands = {
	["blink.cmp"] = shell_build("cargo build --release"),
	["telescope-fzf-native.nvim"] = shell_build(
		"cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
	),
	["blink.pairs"] = function()
		require("blink.pairs").build():pwait(60000)
	end,
}

vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(event)
		if event.data.kind ~= "install" and event.data.kind ~= "update" then
			return
		end

		local build = build_commands[event.data.spec.name]
		if build then
			build(event.data.path)
		end
	end,
})

vim.pack.add(plugins, { confirm = false, load = true })

require("plugins.colorscheme")
require("plugins.common")
require("plugins.aesthetics")
require("plugins.completion")
require("plugins.debugging")
require("plugins.formatter")
require("plugins.lint")
require("plugins.lsp")
require("plugins.telescope")
require("plugins.treesitter")
