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
" I COPIED THIS STR8 FROM GITHUB, BABY!

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" End coc.nvim completion options
