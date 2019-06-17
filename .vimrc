" Set tab size to 4
set tabstop=4
set shiftwidth=4

" I dont know what it is but keep it
set laststatus=2
set noshowmode

" Avoid compatibility mode aka dont act like vi
set nocompatible

" Allow Hybrid numbers, show both current absolute numbers and relative numbers
set number relativenumber

" Movements between tabs
nnoremap tn :tabn<CR>
nnoremap tp :tabp<CR>

" Remap the Nerdtree toggle command
:command Tree NERDTreeToggle

" Install the vim-plug plugin manager
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Begins Vim plug section
call plug#begin()

" git branch name
Plug 'itchyny/vim-gitbranch'

" status line
Plug 'itchyny/lightline.vim'

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name'
      \ },
      \ }

" Ale - Syntax checker
Plug 'w0rp/ale'

" Nertree - file tree visualizer
Plug 'https://github.com/scrooloose/nerdtree.git'
" Open nerdtree on start and close it if it's the only thing left
autocmd vimenter * NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" git gutter
Plug 'airblade/vim-gitgutter'
" icons
Plug 'ryanoasis/vim-devicons'

call plug#end()
" Ends Vim plug section

let g:ale_enabled = 1
