"common vim config setup
set showcmd
set tabstop=2 shiftwidth=2 softtabstop=2
"set tabstop=4 shiftwidth=4 softtabstop=4
set expandtab
syntax on
filetype plugin indent on
set number
set relativenumber
set splitbelow
set splitright
set hlsearch
set guicursor=
"disable auto comment
autocmd FileType * set formatoptions-=ro

autocmd FileType c setlocal colorcolumn=100 tabstop=4 shiftwidth=4 softtabstop=4
autocmd FileType cpp setlocal colorcolumn=100 tabstop=4 shiftwidth=4 softtabstop=4 cindent cino=j1,(0,ws,Ws
autocmd FileType make call SetMakeOptions()
autocmd FileType asm call SetAsmOptions()
autocmd FileType txt call SetTextOptions()
autocmd FileType tex call SetLatexOptions()
autocmd FileType i3rc setlocal filetype=i3

hi SpellBad         ctermbg=88    ctermfg=7
hi WordUnderCursor  ctermbg=111   ctermfg=0
hi TabLineFill      ctermfg=240
hi TabLine          ctermfg=250   ctermbg=0
hi Folded           ctermbg=238
hi Pmenu            ctermbg=238   ctermfg=253
hi PmenuSel         ctermbg=245   ctermfg=0
hi PmenuSbar        ctermbg=236
hi PmenuThumb       ctermbg=242
hi VertSplit        ctermbg=240   ctermfg=232
hi ColorColumn      ctermbg=8

nmap s o<ESC>
nmap S O<ESC>
nmap Y y$
nmap D "0y$d$
nmap <C-h> :match None<Enter>:noh<Enter>
nmap <C-j> gj
nmap <C-k> gk
nmap <Insert> "+p
imap <Insert> <C-r>+
nnoremap <C-K> :%s/\s\+$//e:noh<Enter>:<C-o>
"nnoremap <C-K> :match WordUnderCursor /\k*\%#\k*/<CR>
nnoremap <C-left> gT
nnoremap <C-right> gt
"st ctrl-arrow fix
map <ESC>[1;5D <C-Left>
map <ESC>[1;5C <C-Right>

onoremap <silent> i$ :<c-u>normal! T$vt$<cr>
vnoremap i$ T$ot$
onoremap <silent> a$ :<c-u>normal! F$vf$<cr>
vnoremap a$ F$of$

"functions
function SetAsmOptions()
  set autoindent
  set colorcolumn=80
  set ft=nasm
  syn match nasmSegRegister "\<r[1-3]\>"
  syn keyword nasmDirective store
  syn keyword nasmDirective cmpje
  syn keyword nasmDirective cmpjn
  syn keyword nasmDirective load
  syn keyword nasmDirective mod
  syn keyword nasmDirective j
  syn keyword nasmMacro PHV
  syn keyword nasmMacro HEADER
  syn keyword nasmMacro PORTMASK
  syn keyword nasmAmdInstruction halt
  syn keyword nasmAmdInstruction exact_match
  syn keyword nasmAmdInstruction longest_prefix_match
  syn keyword nasmAmdInstruction hash
endfunction

function SetTextOptions()
  XkbSwitchEnable
  setlocal linebreak
  setlocal spell spelllang=en,ru
  "nnoremap k gk
  "nnoremap j gj
endfunction

function SetLatexOptions()
  XkbSwitchEnable
  setlocal spell spelllang=en,ru
  set tw=80
  autocmd BufWritePost *.tex silent! execute "!pdflatex --shell-escape -interaction=nonstopmode % >/dev/null 2>&1" | redraw!
  "autocmd BufWritePost *.tex execute ':!pdflatex -interaction=nonstopmode %' | call feedkeys(" ")
  nmap m :!zathura "$(echo % \| sed 's/tex$/pdf/')" > /dev/null 2>&1 &<CR><CR>
endfunction

function SetMakeOptions()
  setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4
  setlocal list listchars=eol:¬,tab:→⠀,trail:~,extends:>,precedes:<
  hi SpecialKey ctermfg=243
  hi NonText ctermfg=243
  hi Invisible ctermfg=0 ctermbg=0
  match Invisible /^$/
endfunction

"plugins
call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdcommenter'
Plug 'SirVer/ultisnips'
Plug 'chrisbra/Colorizer'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'lyokha/vim-xkbswitch'
Plug 'lervag/vimtex'
Plug 'justinmk/vim-syntax-extra'
Plug 'jonsmithers/vim-html-template-literals'
Plug 'pangloss/vim-javascript'
Plug 'xavierd/clang_complete'
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
"Plug 'octol/vim-cpp-enhanced-highlight'
"Plug 'honza/vim-snippets'
"Plug 'Valloric/YouCompleteMe'
call plug#end()
let g:coc_node_path = '/usr/bin/nodejs'
let g:tex_flavor = 'latex'

"plugins setup
set formatoptions-=cro

"themes and look
"colorscheme desert
"colorscheme gruvbox
set bg=dark


"set statusline=\ %{mode()}\ %t\ %m\ %=%y\ ≡\ %c:%l\ %p%%\
"airline setup
let g:airline#extensions#keymap#enabled = 0
"let g:airline_powerline_fonts = 1
let g:airline_theme = 'base16_colors'

"let g:airline_theme = 'dark'
"let g:airline_theme = 'violet'
"let g:airline_theme = 'base16'

"snipset setup
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-d>"
let g:UltiSnipsJumpBackwardTrigger="<c-e>"
let g:UltiSnipsSnippetDirectories = ['/home/demiler/.vim/ultisnips']
let g:UltiSnipsEditSplit="vertical"

"let g:clang_library_path = '/usr/lib/llvm-6.0/lib'
"let g:clang_close_preview = 1

let g:XkbSwitchIMappings = ['ru']

"highlight thing inside css`...` too
let g:htl_css_templates = 1
