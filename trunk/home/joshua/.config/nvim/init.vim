" ************************************
" Josh's terrible Neovim configuration
" ************************************

" Use vim plugins, hopefully
set rtp^=/usr/share/vim/vimfiles/

" Syntax highlighting and indentation
set autoindent
set smartindent
set smartcase
filetype plugin on
filetype indent on
syntax on
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab

" Turn on line numbers
set number

" Turn on terminal color support (?)
set termguicolors
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" Check for file updates
set autoread

" UTF-8 on by default
scriptencoding utf-8
set encoding=utf-8
set emoji

" Case insensitive searching
set ignorecase

" Set spelling correction stuff
set spelllang=en_us

" Temporary files/backup
set backup
set backupdir=/tmp/
set directory=/tmp/
set undodir=/tmp/

" Use the system's clipboard
set clipboard+=unnamedplus

" Wildmenu
set wildmenu
set wildignorecase
set wildmode=longest,full
set wildoptions=pum
set pumblend=20

" Allow moving to the next line using arrows
set whichwrap+=<,>,h,l

" Wrapping options
set colorcolumn=80
set wrap
set linebreak

" Misc
set secure
let c_space_error=1
set backspace=2
set nojoinspaces
" Needed for mouse in zellij
set mouse=a

" Settings for specific file types
" (Yes, I have to clean this up)
autocmd BufRead,BufNewFile *.md setlocal spell "setlocal complete+=kspell
autocmd BufRead,BufNewFile *.Rmd setlocal spell "setlocal complete+=kspell
autocmd BufRead,BufNewFile *.txt setlocal spell "setlocal complete+=kspell
autocmd BufRead,BufNewFile *.tex setlocal spell "setlocal complete+=kspell
autocmd FileType gitcommit setlocal spell "setlocal complete+=kspell
autocmd FileType rust setlocal colorcolumn=100

" Keybindings


" Options required for plugins - notably coc.nvim
set hidden
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes

" Plugins
call plug#begin('~/.config/nvim/vimplugins')

" List of plugins to install/load
Plug 'tpope/vim-sensible'
Plug 'vim-airline/vim-airline'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-sleuth'
Plug 'scrooloose/nerdtree'
Plug 'sheerun/vim-polyglot'
" Replace coc.nvim later
" Plug 'neovim/nvim-lsp'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-eslint', {'branch': 'release'}
Plug 'neoclide/coc-prettier', {'branch': 'release'}
Plug 'josa42/coc-lua', {'branch': 'release'}
Plug 'josa42/coc-sh', {'branch': 'release'}
Plug 'clangd/coc-clangd', {'do': 'yarn install --frozen-lockfile'}
" Plug 'voldikss/coc-cmake', {'do': 'yarn install --frozen-lockfile'}
" Plug 'pappasam/coc-jedi', {'do': 'yarn install --frozen-lockfile && yarn build', 'branch': 'main'}
Plug 'fannheyward/coc-pyright'
Plug 'yaegassy/coc-sqlfluff'
Plug 'neoclide/coc-r-lsp', {'do': 'yarn install --frozen-lockfile'}
Plug 'bash-lsp/bash-language-server', {'do': 'yarn install --frozen-lockfile'}
" Plug 'neoclide/coc-rls'
Plug 'fannheyward/coc-rust-analyzer', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-vimtex', {'do': 'yarn install --frozen-lockfile'}
Plug 'frazrepo/vim-rainbow'
Plug 'liuchengxu/vista.vim'
Plug 'tpope/vim-commentary'
Plug 'junegunn/fzf.vim'
" Lua stuff for later
Plug 'nvim-lua/plenary.nvim'


" PLUGINS: Colorschemes
"Plug 'nanotech/jellybeans.vim'
"Plug 'junegunn/seoul256.vim'
"Plug 'joshdick/onedark.vim'
Plug 'morhetz/gruvbox'
"Plug 'cocopon/iceberg.vim'
"Plug 'altercation/vim-colors-solarized'
"Plug 'sickill/vim-monokai'
Plug 'dracula/vim'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" Plugin options
let g:gruvbox_improved_strings = '1'
let g:gruvbox_improved_warnings = '1'
let g:LanguageClient_autoStart = '1'
" colorscheme dracula
colorscheme dracula
let g:airline_theme = 'dracula'
let g:rustfmt_autosave = 1

" coc.nvim completion options
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
	\ pumvisible() ? "\<C-n>" :
	\ <SID>check_back_space() ? "\<Tab>" :
	\ coc#refresh()

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" End coc.nvim completion options
