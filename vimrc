call plug#begin('~/vimfiles/plugged')
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries'}
Plug 'scrooloose/nerdtree'
call plug#end()


"http://stackoverflow.com/questions/20186975/vim-mac-how-to-copy-to-clipboard-without-pbcopy
set clipboard^=unnamed
set clipboard^=unnamedplus


" color
syntax enable
set t_Co=256
"set background=dark
colorscheme blue
