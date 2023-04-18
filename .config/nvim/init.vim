" Plugins and functions
source ~/.config/nvim/plugins.vim
source ~/.config/nvim/functions.vim

" NVIM variable settings
set guicursor=
set mouse=
autocmd VimEnter * TSEnable highlight | set formatoptions-=ro
set formatoptions-=ro
set updatetime=50

set scrolloff=8
set expandtab tabstop=2 shiftwidth=2 softtabstop=2
set relativenumber number

set splitbelow splitright
set hlsearch

" autocommands
autocmd FileType tex call SetLatexOptions()
autocmd FileType c setlocal colorcolumn=100 tabstop=4 shiftwidth=4 softtabstop=4
autocmd FileType cpp setlocal colorcolumn=100 tabstop=4 shiftwidth=4 softtabstop=4 cindent cino=j1,(0,ws,Ws
autocmd BufRead,BufNewFile *.njk setlocal ft=html
autocmd BufRead,BufNewFile ~/.ssh/config.d/* setlocal ft=sshconfig

" commands
command! RemoveTrailing :silent!%s/ \+$// | :noh
command! LuaSnipEdit :lua require('telescope.builtin').find_files({ cwd = '~/.config/nvim/snippets' })<CR>

" Keybindings
let g:mapleader = ';'
nnoremap S O<ESC>
nnoremap s o<ESC>
nmap <leader>r :set rnu!<CR>
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <C-right> gt
nnoremap <C-left> gT
nnoremap <leader>f :Telescope find_files<CR>
nnoremap <leader>h :noh<CR>
imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>

" Colors
colorscheme zephyr  " doesn't support html`` highlighting
" hi TabLineFill      guifg=#202020
" hi TabLineSel       guifg=#000000 guibg=#61afef
colorscheme doom-one " this one does
hi LineNr guifg=#6f747a
