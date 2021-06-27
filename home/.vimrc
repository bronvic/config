" No arrow keys --- force yourself to use the home row
nnoremap <up> <nop>
nnoremap <down> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

:set number relativenumber

" Rust plugin https://github.com/rust-lang/rust.vim/
syntax enable
filetype plugin indent on

" As-you-type autocomplete
set completeopt=menu,menuone,preview,noselect,noinsert
let g:ale_completion_enabled = 1

let g:ale_fixers = { 'rust': ['rustfmt', 'trim_whitespace', 'remove_trailing_lines'] }

" Required, explicitly enable Elixir LS
let g:ale_linters = {
\  'rust': ['analyzer'],
\}

" select autocomplete by tab
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"

" markdown
let g:vim_markdown_folding_disabled = 1

" Exercism
function! s:exercism_tests()
  if expand('%:e') == 'vim'
    let testfile = printf('%s/%s.vader', expand('%:p:h'),
          \ tr(expand('%:p:h:t'), '-', '_'))
    if !filereadable(testfile)
      echoerr 'File does not exist: '. testfile
      return
    endif
    source %
    execute 'Vader' testfile
  else
    let sourcefile = printf('%s/%s.vim', expand('%:p:h'),
          \ tr(expand('%:p:h:t'), '-', '_'))
    if !filereadable(sourcefile)
      echoerr 'File does not exist: '. sourcefile
      return
    endif
    execute 'source' sourcefile
    Vader
  endif
endfunction

autocmd BufRead *.{vader,vim}
      \ command! -buffer Test call s:exercism_tests()

" ctrlp fuzzy finder
set wildignore+=*/_vendor/*
let g:ctrlp_working_path_mode = 'ra'

" NERDTree settings
nmap <C-f> :NERDTreeToggle<CR>

" Start NERDTree and leave the cursor in it.
autocmd VimEnter * NERDTree

" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
