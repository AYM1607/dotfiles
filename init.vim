if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

let mapleader = "\<Space>"

" Plugins section starts.
call plug#begin('~/.config/nvim/plugged')

Plug 'drewtempelmeyer/palenight.vim'

" Syntax.
Plug 'sheerun/vim-polyglot'

" Folding
Plug 'tmhedberg/SimpylFold'
Plug 'Konfekt/FastFold'

" Web stuff.
Plug 'mxw/vim-jsx'
Plug 'othree/jsdoc-syntax.vim'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

"C/C++ stuff.
Plug 'jackguo380/vim-lsp-cxx-highlight'

Plug 'machakann/vim-highlightedyank'

" COC (Autocomplete and Intellisense).
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Prettier.
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }

" Fuzzy finder.
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" This is needed to ignore files in gitignore.
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

Plug 'jiangmiao/auto-pairs'

Plug 'itchyny/lightline.vim'

Plug 'preservim/nerdtree'

Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'tpope/vim-fugitive'

Plug 'airblade/vim-gitgutter'

Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

Plug 'ryanoasis/vim-devicons'

Plug 'psf/black', { 'tag': '19.10b0' }

call plug#end()

set noshowmode
set background=dark
colorscheme palenight

" Open NERDTree when opening a directory.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" Close vim if NERDTree is the only thing remaining.
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Map it to command+b.
map <C-b> :NERDTreeToggle<CR>

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

" Add new line after or before the current line.
" nnoremap <silent> oo :<C-u>call append(line("."),   repeat([""], v:count1))<CR>
" nnoremap <silent> OO :<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>

" Always use 2 spaces as tabs.
set tabstop=2     " Size of a hard tabstop (ts).
set shiftwidth=2  " Size of an indentation (sw).
set expandtab     " Always uses spaces instead of tab characters (et).
set softtabstop=0 " Number of spaces a <Tab> counts for. When 0, featuer is off (sts).
set autoindent    " Copy indent from current line when starting a new line.
set smarttab      " Inserts blanks on a <Tab> key (as per sw, ts and sts).

" Call this in case I have to use tabs, like in a makefile for example.
" Usage: :call UseTabs()
function! UseTabs()
  set tabstop=4     " Size of a hard tabstop (ts).
  set shiftwidth=4  " Size of an indentation (sw).
  set noexpandtab   " Always uses tabs instead of space characters (noet).
  set autoindent    " Copy indent from current line when starting a new line (ai).
endfunction

" Quick-save
nmap <leader>w :w<CR>

" Hybrid numbering (both relative and absoulte) 
:set number relativenumber
" Automatically set absolute numbering when inserting and when not in focus.
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END

" Set python3 executable
let g:python3_host_prog="/usr/local/bin/python3"

""""""""""""""" CoC config.
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use K to show documentation in preview window.
nnoremap <silent> <leader>K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')
""""""""""""""" End coc config.

""""""""""""""" Prettier config.
let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0
let g:prettier#exec_cmd_async = 1
""""""""""""""" End prettier config.

" Open hotkeys
map <C-p> :Files<CR>
nmap <leader>; :Buffers<CR>

" Jump to start and end of line using the home row keys
map H ^
map L $

" <leader><leader> toggles between buffers
nnoremap <leader><leader> <c-^>

" Easily move between buffers.
nnoremap J :bp<CR>
nnoremap K :bn<CR>

" Use rg as search engine.
noremap <leader>s :Rg
if executable('rg')
	set grepprg=rg\ --no-heading\ --vimgrep
	set grepformat=%f:%l:%c:%m
endif

" Turn off highlight until next search.
set nohlsearch

" Configure black service.
let g:black_virtualenv="~/.config/nvim/black"
" Run balck on every save for python files.
autocmd BufWritePre *.py execute ':Black'

" Map Ctrl+k as esc for all modes.
nnoremap <C-k> <Esc>
inoremap <C-k> <Esc>
vnoremap <C-k> <Esc>
snoremap <C-k> <Esc>
xnoremap <C-k> <Esc>
cnoremap <C-k> <Esc>
onoremap <C-k> <Esc>
lnoremap <C-k> <Esc>
tnoremap <C-k> <Esc>

" Map jk and kj to esc for insert mode.
inoremap jk <Esc>
inoremap kj <Esc>

" Use Ctrl+n to go to next search result withouth exiting search mode.
:cnoremap <c-n> <CR>n/<c-p>

" Autoread files when changes are detected.
set autoread

set foldmethod=syntax
set foldnestmax=2
set foldlevelstart=1

" Command to delete all buffers except the current one.
command! BufOnly silent! execute "%bd|e#|bd#"

" Command to exit vim, deletes the NERDTree buffer too.
command! Quit execute "q|q"
