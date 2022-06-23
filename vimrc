"
"{{{ au FileType
syntax on
augroup filetypes
autocmd!
au FileType vim set foldmethod=marker
au FileType python set foldmethod=indent
au FileType markdown setlocal spell
au FileType markdown nnoremap k gk
au FileType markdown nnoremap j gj
au FileType markdown nnoremap gk k
au FileType markdown nnoremap gj j
au FileType julius set syntax=javascript
au BufRead /tmp/psql.edit.* set syntax=sql
au FileType hamlet set syntax=html
au FileType haskell nnoremap <buffer> <F1> :HdevtoolsType<CR>
au FileType haskell nnoremap <buffer> <silent> <F2> :HdevtoolsClear<CR>
au FileType haskell nnoremap <buffer> <silent> <F3> :HdevtoolsInfo<CR>
au BufRead,BufNewFile *.mjcf setfiletype xml
autocmd BufNewFile,BufRead .pyre_configuration set syntax=json
augroup END
"}}}

"{{{ let
let mapleader = " "
let $PATH = '/usr/bin:' . $PATH . ':' . '$HOME/.local/bin/'
"let g:syntastic_check_on_open=1
"let g:syntastic_cpp_compiler = 'clang++'
"let g:syntastic_cpp_compiler_options = ' -std=c++14 -stdlib=libc++'
"let g:syntastic_python_checkers = ['flake8']
"let g:syntastic_haskell_checkers = ['hlint', 'hdevtools']

" jedi-vim
let g:python_host_prog  = '/home/ethanbro/virtualenvs/neovim2/bin/python'
let g:python3_host_prog  = '/home/ethanbro/virtualenvs/neovim/bin/python'

" When the type of shell script is /bin/sh, assume a POSIX-compatible
" shell for syntax highlighting purposes.
let g:is_posix = 1

let g:vimtex_view_general_viewer = 'okular'
"let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
"let g:vimtex_view_general_options_latexmk = '--unique'
let g:vimtex_compiler_latexmk = {
      \ 'build_dir' : 'build',
      \}

let g:ale_linters = {'python': ['pylint', 'pyls']}
let g:ale_fixers = {'c': ['clang-format'], 'python': ['black'], 'json': ['prettier'], 'yaml': ['prettier']}
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1
let g:ale_python_pyls_auto_pipenv = 1

let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'absolutepath', 'modified' ] ],
      \ }
      \ }
let g:lightline.colorscheme = 'gruvbox'

"let g:pymode_options_max_line_length = 90
"let g:pymode_python = 'python3'
"let g:pymode_rope = 1
"let g:pymode_rope_autoimport=1
"}}}
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'absolutepath', 'modified' ] ],
      \ }
      \ }

"{{{ map
nnoremap <leader>w :w<CR>
nnoremap <C-w> :close<CR>
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <F4> :Autoformat<CR>

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

"execute this file
"nnoremap <C-x> :execute "!./" . expand('%:t')<CR>

"execute last command
nnoremap <leader>x :<up><CR>

"save
nnoremap <leader>w :w<CR>

" fzf
nnoremap <C-p> :Files<CR>

" break
nnoremap <leader>b Obreakpoint()<ESC>

nnoremap <leader>k :ALEPrevious<CR>
nnoremap <leader>j :ALENext<CR>
command! ALEDisableFixers       let g:ale_fix_on_save=0
command! ALEEnableFixers        let g:ale_fix_on_save=1

"}}}

"{{{ plug
call plug#begin('~/.vim/bundle')
if filereadable(expand("~/.config/nvim/bundles.vim"))
  source ~/.config/nvim/bundles.vim
endif
call plug#end()
"}}}

"{{{ set
set t_Co=256
set guifont="Droid Sans Mono":h14

set textwidth=0 wrapmargin=0   " prevent line splitting https://stackoverflow.com/a/2280128/4176597
set noswapfile
set incsearch     " incremental searching
set autowrite     " :write before leaving file
set background=dark 
set tabstop=2 " show existing tab with 2 spaces width
set shiftwidth=2 " when indenting with '>', use 2 spaces width 
set textwidth=80 
set expandtab " On pressing tab, insert 2 spaces
set list listchars=tab:»·,trail:·,nbsp:· " Display extra whitespace
set number
set numberwidth=1
set complete+=kspell " Autocomplete with dictionary words when spell check is on
set cursorline
set wildmenu
set lazyredraw  " maybe faster with macros
set mouse=a

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

"}}}

"{{{ command!
"easy source virmc
command! Sovim source $MYVIMRC
"easy update plugins
command! Replug source $MYVIMRC | PlugUpgrade | PlugUpdate | PlugClean | PlugInstall
"delete trailing whitespace
command! Despace %s/\s\+\n/\r/g
"}}}

"{{{ Hashbang
function! Hashbang(portable, permission, RemExt)
  let shells = {
        \    'awk': "awk",
        \     'sh': "bash",
        \     'hs': "stack",
        \     'jl': "julia",
        \    'lua': "lua",
        \    'mak': "make",
        \     'js': "node",
        \      'm': "octave",
        \     'pl': "perl",
        \    'php': "php",
        \     'py': "python",
        \      'r': "Rscript",
        \     'rb': "ruby",
        \  'scala': "scala",
        \    'tcl': "tclsh",
        \     'tk': "wish",
        \  'swift': "swift"
        \    }

  let extension = expand("%:e")

  if has_key(shells,extension)
    let fileshell = shells[extension]

    if a:portable
      let line =  "#! /usr/bin/env " . fileshell
    else
      let line = "#! " . system("which " . fileshell)
    endif

    0put = line

    if a:permission
      :autocmd BufWritePost * :autocmd VimLeave * :!chmod u+x %
    endif


    if a:RemExt
      :autocmd BufWritePost * :autocmd VimLeave * :!mv % "%:p:r"
    endif

  endif

endfunction
autocmd BufNewFile * :call Hashbang(1,0,0)
"}}}

scriptencoding utf-8
set encoding=utf-8
filetype plugin indent on
colorscheme gruvbox
 
