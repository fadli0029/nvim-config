set commentstring=//\ %s

" Disable inserting comment leader after hitting o or O or <Enter>
set formatoptions-=o
set formatoptions-=r

" Match ~/Scripts/.clang-format (Google style)
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" cinoptions to approximate Google C style
" g1     - access specifiers at 1 space indent
" N-s    - no namespace indent
" E-s    - no extern "C" indent
" (0     - align to first char after unclosed paren
" W2s    - 4-space continuation when paren at EOL (ContinuationIndentWidth: 4)
" :0,l1  - case labels at switch level, align with label not statement
set cinoptions=g1,N-s,E-s,(0,W2s,:0,l1

" Insert comment with timestamp (type //d or /*d in insert mode)
inoremap <buffer> //d <C-R>=strftime('// [%Y-%m-%d %H:%M] ')<CR>
inoremap <buffer> /*d <C-R>=strftime('/* [%Y-%m-%d %H:%M] ')<CR>
