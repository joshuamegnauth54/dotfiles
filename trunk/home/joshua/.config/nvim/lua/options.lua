-- General variables and options
-- Other settings may be found in specific files

-- set => equivalent to vim script's "set"
-- g => global
local set = vim.opt
local g = vim.g

-- Disable unused built-in plugins.
-- Some plugins, such as nvim-tree, require disabling a few of these anyway.
-- These plugins aren't anything I'd use either.
local disabled_plugins = {
	"2html_plugin",
	"bugreport",
	"compiler",
	"getscript",
	"getscriptPlugin",
	"gzip",
	"logipat",
	"netrw",
	"netrwPlugin",
	"netrwSettings",
	"netrwFileHandlers",
	"matchit",
	"matchparen",
	"optwin",
	"rplugin",
	"rrhelper",
	"spellfile_plugin",
	"synmenu",
	"tar",
	"tarPlugin",
	"tohtml",
	"tutor",
	"vimball",
	"vimballPlugin",
	"zip",
	"zipPlugin",
}

for _, plugin in pairs(disabled_plugins) do
	g["loaded_" .. plugin] = 1
end

-- Disable unused plugin providers. I only wish to use Lua and vimscript plugins.
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
g.loaded_node_provider = 0
g.loaded_python_provider = 0
g.loaded_python3_provider = 0

-- Set leader to comma
g.mapleader = ","
g.maplocalleader = ","

-- Syntax highlighting
g.background = "dark"
g.syntax = true
set.termguicolors = true

-- Line numbers
set.number = true

-- Enable sign column (should be populated with information via plugins)
-- "yes" rather than a boolean is correct.
-- This should always be enabled or else the sign column would move when toggled
set.signcolumn = "yes"

-- Enable mouse support (I need this for zellij)
set.mouse = "a"

-- Disable scrolling off at N extra lines
set.scrolloff = 0

-- Soft wrapping and not breaking in the middle of a word
set.wrap = true
set.linebreak = true

-- Indentation
set.expandtab = true
set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4

-- Allow swapping buffers if current isn't saved
set.hidden = true

-- Disallow .vimrc from calling shell commands(?)
set.secure = true

-- Modify command height (the thingy at the bottom)
-- 0 looks nicer. The default is 1. I had 2 set previously for some reason.
set.cmdheight = 0

-- Disable certain messages so prevent hit-enter prompts (useful in conjunction with the above)
-- set.shortmess:append("scIW")

-- Automatically check if file was modified
set.autoread = true

-- Use UTF-8
-- set.encoding = "utf-8"
-- set.fileencoding = "utf-8"
set.emoji = true

-- Search options
set.ignorecase = true
set.smartcase = true
set.incsearch = true
set.hlsearch = true

-- Speeling (sp?)
-- Next: ]s
-- Prev: [s
-- Suggestions: z=
set.spelllang = "en_us"
set.spell = true

-- Splits don't shift current buffer
set.splitright = true
set.splitbelow = true

-- Write temporary files and back ups to temp_dir
local temp_dir = "/tmp/nvim/" .. (vim.env.USER or vim.env.USERNAME or "unknown-" .. math.random())
set.backup = true
set.writebackup = true
set.undofile = true
set.backupdir = temp_dir .. "/backup//"
set.directory = temp_dir .. "swap//"
set.undodir = temp_dir .. "/undo//"

-- Use ripgrep for grep
set.grepprg = "rg --vimgrep"

-- Use the system's clipboard
set.clipboard = "unnamedplus"

-- Allow moving to the next line with h, l, and arrows
set.whichwrap = "b,s,<,>,h,l"

-- Intuitive backspaces
set.backspace = "indent,eol,start"

-- Built in neovim completion; this is useful for the command bar
set.wildignorecase = true
set.wildmode = "longest:full,full"
-- Transparency
set.pumblend = 20
-- Maximum number of items to show
set.pumheight = 10

-- Single status line for all neovim windows
set.laststatus = 3
vim.api.nvim_set_hl(0, "WinSeparator", { bg = "None", default = true })

-- Highlight cursor line so I don't get lost
set.cursorline = true

-- Disable LSP logging unless I need it
vim.lsp.log.set_level("OFF")

-- Set up autocomplete defaults for blink.cmp
-- set.completeopt = { "menuone", "noselect", "noinsert" }
-- Reduce update tic time from 4000 to 250 to decrease perceived latency
vim.api.nvim_set_option("updatetime", 250)

-- Diagnostics

-- Virtual text doesn't work as nicely as I'd want it to, so I'll use floating windows instead
-- severity_sort: https://github.com/nvimdev/lspsaga.nvim/issues/1520
vim.diagnostic.config({
	virtual_text = false,
	severity_sort = true,
	underline = true,
	signs = {
		text = {
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.HINT] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.ERROR] = "󰋔",
		},
		numhl = {
			[vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
			[vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
			[vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
			[vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
		},
	},
})
-- vim.cmd([[autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })]])
-- vim.api.nvim_create_autocmd({ "CursorHold" }, {
-- 	callback = function()
-- 		vim.diagnostic.open_float(nil, { focusable = false })
-- 	end,
-- 	desc = "Open diagnostic floating window on cursor hold",
-- })

-- Highlight yanked text
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	callback = function()
		vim.hl.on_yank()
	end,
	desc = "Highlight text on yank",
})
