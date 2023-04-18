function! SetLatexOptions()
    set keymap=russian-jcukenwin
    imap <C-space> <C-^>
    setlocal spell spelllang=en,ru
    set tw=80
    autocmd BufWritePost *.tex silent! execute "!pdflatex --shell-escape -interaction=nonstopmode % >/dev/null 2>&1 &" | redraw!
    "autocmd BufWritePost *.tex execute ':!pdflatex -interaction=nonstopmode %' | call feedkeys(" ")
    nmap <leader>m :!zathura "$(echo % \| sed 's/tex$/pdf/')" > /dev/null 2>&1 &<CR><CR>
endfunction
