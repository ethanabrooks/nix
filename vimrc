colorscheme gruvbox
let mapleader = " "

nnoremap <leader>w :w<CR>
nnoremap <C-w> :close<CR>
nnoremap <C-p> :Files<CR>

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

let g:ale_fix_on_save = 1
let g:ale_fixers = {
			\ 'python': ['black'], 
			\ 'json': ['prettier'], 
			\ 'yaml': ['prettier'],
			\ 'nix': ['nixfmt'],
			\ }

set textwidth=0 wrapmargin=0 " prevent line splitting https://stackoverflow.com/a/2280128/4176597
set noswapfile
set incsearch                " incremental searching
set autowrite                " :write before leaving file
set background=dark 
set tabstop=2                " show existing tab with 2 spaces width
set shiftwidth=2             " when indenting with '>', use 2 spaces width 
set textwidth=80 
set expandtab                " On pressing tab, insert 2 spaces
set list listchars=tab:»·,trail:·,nbsp:· " Display extra whitespace
set number
set numberwidth=1
set complete+=kspell         " Autocomplete with dictionary words when spell check is on
set cursorline

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

