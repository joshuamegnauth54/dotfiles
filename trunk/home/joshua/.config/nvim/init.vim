" ************************************
" Josh's terrible Neovim configuration
" ************************************

" Use vim plugins, hopefully
set rtp^=/usr/share/vim/vimfiles/

" Syntax highlighting and indentation
set autoindent
set smartindent
set smartcase
set smarttab
filetype plugin on
filetype indent on
syntax on

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

" Temporary files/backup
set backup
set backupdir=/tmp/
set directory=/tmp/
set undodir=/tmp/

" Use the system's clipboard
set clipboard+=unnamedplus

" Wildmenu
set wildmenu
set wildmode=longest,full
set wildoptions=pum

" Misc
set secure

" Options required for plugins - notably coc.nvim
set hidden
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes
" let g:tmux_navigator_no_mappings = 1
" nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
" nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
" nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
" nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
" Disable tmux navigator when zooming the Vim pane
" let g:tmux_navigator_disable_when_zoomed = 1

" Plugins
call plug#begin('~/.config/nvim/vimplugins')

" List of plugins to install/load
Plug 'tpope/vim-sensible'
Plug 'vim-airline/vim-airline'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
" Plug 'christoomey/vim-tmux-navigator'
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'clangd/coc-clangd', {'do': 'yarn install --frozen-lockfile'}
Plug 'voldikss/coc-cmake', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-python', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-r-lsp', {'do': 'yarn install --frozen-lockfile'}
Plug 'bash-lsp/bash-language-server', {'do': 'yarn install --frozen-lockfile'}
" Plug 'neoclide/coc-rls'
Plug 'fannheyward/coc-rust-analyzer', {'do': 'yarn install --frozen-lockfile'}
Plug 'frazrepo/vim-rainbow'
Plug 'nanotech/jellybeans.vim'
Plug 'junegunn/seoul256.vim'
Plug 'joshdick/onedark.vim'
Plug 'morhetz/gruvbox'
Plug 'cocopon/iceberg.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'sickill/vim-monokai'
Plug 'dracula/vim'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" Plugin options
let g:gruvbox_improved_strings = '1'
let g:gruvbox_improved_warnings = '1'
let g:LanguageClient_autoStart = '1'
" colorscheme gruvbox
colorscheme gruvbox

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
