set commentstring=//\ %s

" Disable inserting comment leader after hitting o or O or <Enter>
set formatoptions-=o
set formatoptions-=r

" Match ~/Scripts/.clang-format (Google style)
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" cinoptions to approximate Google C++ style
" g1     - access specifiers (public/private) at 1 space indent (simulates -1 offset)
" N-s    - no namespace indent (NamespaceIndentation: None)
" E-s    - no extern "C" indent
" (0     - align to first char after unclosed paren
" W2s    - 4-space continuation when paren at EOL (ContinuationIndentWidth: 4)
" :0,l1  - case labels at switch level, align with label not statement
set cinoptions=g1,N-s,E-s,(0,W2s,:0,l1

" Insert comment with timestamp (type //d or /*d in insert mode)
inoremap <buffer> //d <C-R>=strftime('// [%Y-%m-%d %H:%M] ')<CR>
inoremap <buffer> /*d <C-R>=strftime('/* [%Y-%m-%d %H:%M] ')<CR>

nnoremap <silent> <buffer> <F9> :call <SID>compile_run_cpp()<CR>

function! s:compile_run_cpp() abort
  let src_path = expand('%:p:~')
  let src_noext = expand('%:p:~:r')
  " The building flags
  let _flag = '-Wall -Wextra -std=c++11 -O2'

  if executable('clang++')
    let prog = 'clang++'
  elseif executable('g++')
    let prog = 'g++'
  else
    echoerr 'No C++ compiler found on the system!'
  endif
  call s:create_term_buf('h', 20)
  execute printf('term %s %s %s -o %s && %s', prog, _flag, src_path, src_noext, src_noext)
  startinsert
endfunction

function s:create_term_buf(_type, size) abort
  set splitbelow
  set splitright
  if a:_type ==# 'v'
    vnew
  else
    new
  endif
  execute 'resize ' . a:size
endfunction

" Use .clang-format file search (searches upward from current file)
let g:neoformat_cpp_clangformat = {
    \ 'exe': 'clang-format',
    \ 'args': ['-style=file'],
    \ }