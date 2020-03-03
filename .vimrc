"russian keybind
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0
highlight lCursor guifg=NONE

"little changes
set showcmd
set tabstop=2 shiftwidth=2 softtabstop=2
set expandtab
syntax on
filetype plugin indent on
set number
set relativenumber
inoremap <C-o> <C-^>
autocmd BufRead,BufNewFile *.c set colorcolumn=80
autocmd BufRead,BufNewFile *.asm call SetAsmOptions()
nmap m o<ESC>
nmap M O<ESC>

"functions
function SetAsmOptions()
  set autoindent
  set colorcolumn=80 
  set ft=nasm
endfunction

"plugins
call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'arcticicestudio/nord-vim'
Plug 'scrooloose/nerdcommenter'
Plug 'lervag/vimtex'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'xavierd/clang_complete'
Plug 'chrisbra/Colorizer'
Plug 'octol/vim-cpp-enhanced-highlight'
"Plug 'lyokha/vim-xkbswitch'
"Plug 'Valloric/YouCompleteMe'
call plug#end()
let g:coc_node_path = '/usr/bin/nodejs'

"themes and look
"colorscheme desert
"colorscheme gruvbox
set bg=dark
highlight ColorColumn ctermbg=8

"airline setup
let g:airline#extensions#keymap#enabled = 0
let g:airline_powerline_fonts = 1
"let g:airline_theme = 'dark'
let g:airline_theme = 'base16_colors'
"let g:airline_theme = 'violet'
"let g:airline_theme = 'base16'

"vimtex setup
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode = 0
"set conceallevel=1
let g:tex_conceal = 'abdmg'

"snipset setup
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-d>"
let g:UltiSnipsJumpBackwardTrigger="<c-e>"
let g:UltiSnipsSnippetDirectories = ['/home/demiler/.vim/ultisnips']
let g:UltiSnipsEditSplit="vertical"

autocmd BufRead,BufNewFile *.i3rc set filetype=i3 

let g:clang_library_path='/usr/lib/llvm-6.0/lib'

"let g:XkbSwitchEnabled = 1
"let g:XkbSwitchLib = "/usr/lib/libxkbswitch.so"
""echo libcall(g:XkbSwitchLib, 'Xkb_Switch_getXkbLayout', '')
"call libcall(g:XkbSwitchLib, 'Xkb_Switch_setXkbLayout', 'us')

