-- Variables and options

-- set => equivalent to vim script's "set"
-- g => global
local set = vim.opt
local g = vim.g

-- Options for plugins so that they don't break
-- For nvim-tree
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

-- Set leader to space
g.mapleader = " "
g.maplocalleader = " "

-- Syntax highlighting
g.background = "dark"
g.t_co = 256
g.syntax = true
set.termguicolors = true

-- Line numbers
set.number = true

-- Enable sign column (should be populated with information via plugins)
-- "yes" rather than a boolean is correct.
set.signcolumn = "yes"

-- Enable mouse support (I need this for zellij)
set.mouse = "a"

-- Disable scrolling off at N extra lines
set.scrolloff = 0

-- Soft wrapping and not breaking in the middle of a word
set.wrap = true
set.linebreak = true

-- Indentation
set.autoindent = true
set.smartindent = true
set.expandtab = true
set.smarttab = true
set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4

-- Joining lines should add one space instead of two
-- This is the default as of 6.0
-- set.nojoinspaces = true

-- Allow swapping buffers if current isn't saved
set.hidden = true

-- Disallow .vimrc from calling shell commands(?)
set.secure = true

-- Modify command height (the thingy at the bottom)
-- 0 looks nicer. The default is 1. I had 2 set previously for some reason.
set.cmdheight = 0

-- Automatically check if file was modified
set.autoread = true

-- Use UTF-8
set.encoding = "utf-8"
set.fileencoding = "utf-8"
set.emoji = true

-- Search options
set.ignorecase = true
set.smartcase = true
set.incsearch = true
set.hlsearch = true

-- Speeling (sp?)
set.spelllang = "en_us"

-- Splits don't shift current buffer
set.splitright = true
set.splitbelow = true

-- Write temporary files and back ups to temp_dir
local temp_dir = "/tmp"
set.backup = true
set.backupdir = temp_dir
set.directory = temp_dir
set.undodir = temp_dir

-- Longer history
set.history = 1000

-- Use the system's clipboard
set.clipboard = "unnamedplus"

-- Allow moving to the next line with h, l, and arrows
set.whichwrap = set.whichwrap + "<" + ">" + "h" + "l"

-- Intuitive backspaces
set.backspace = "indent,eol,start"

-- Built in neovim completion; this is useful for the command bar
set.wildmenu = true
set.wildignorecase = true
set.wildmode = "longest,full"
set.wildoptions = "pum"
set.pumblend = 20
