syntax on
set t_Co=256
set cursorline
colorscheme onehalflight
" If you have vim >=8.0 or Neovim >= 0.1.5
if (has("termguicolors"))
 set termguicolors
endif
let g:oceanic_next_terminal_bold = 1
  let g:oceanic_next_terminal_italic = 1
  colorscheme OceanicNext

let g:lightline.colorscheme = 'gruvbox'

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
			\ }
			"\ 'nix': ['nixfmt'],

lua << EOF
local null_ls = require("null-ls")

-- register any number of sources simultaneously
local sources = {
    null_ls.builtins.formatting.alejandra
}

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
null_ls.setup({
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					-- TODO: change once nvim 0.8 is released:
					-- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts
					local params = vim.lsp.util.make_formatting_params({})
					client.request("textDocument/formatting", params, nil, bufnr)
				end,
			})
		end
	end, 
  sources = sources})
EOF

set textwidth=0 wrapmargin=0 " prevent line splitting https://stackoverflow.com/a/2280128/4176597

"https://realpython.com/vim-and-python-a-match-made-in-heaven/#python-indentation
au BufNewFile,BufRead *.py
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=79
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix

set noswapfile
set incsearch                " incremental searching
set autowrite                " :write before leaving file
set background=dark 
set list listchars=tab:»·,trail:·,nbsp:· " Display extra whitespace
set number
set numberwidth=1
set complete+=kspell         " Autocomplete with dictionary words when spell check is on

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

"https://realpython.com/vim-and-python-a-match-made-in-heaven/#flagging-unnecessary-whitespace
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

