set number
set termguicolors
set ts=4 sw=4
set background=dark
set termguicolors

call plug#begin("~/.config/nvim/plugged")

Plug 'joshdick/onedark.vim'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'itchyny/lightline.vim'

call plug#end()

let g:onedark_hide_endofbuffer = 1
let g:onedark_termcolors = 256
let g:onedark_terminal_italics = 1 

colorscheme onedark

if !has('gui_running')
  set t_Co=256
endif

let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ }

highlight Normal guibg=none
highlight NonText guibg=none
