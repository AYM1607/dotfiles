" Mappings
nnoremap tn :tabn<CR>
nnoremap tp :tabp<CR>

" Plugins "
call plug#begin('~/.vim/plugged')
" status line "
Plug 'itchyny/lightline.vim'
set laststatus=2
set noshowmode
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

" git branch name
Plug 'itchyny/vim-gitbranch'
" NerdTree
Plug 'scrooloose/nerdtree'
autocmd vimenter * NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" git gutter
Plug 'airblade/vim-gitgutter'
" icons
Plug 'ryanoasis/vim-devicons'
call plug#end()

if !has('gui_running')
	set t_Co=256
endif
set encoding=UTF-8
