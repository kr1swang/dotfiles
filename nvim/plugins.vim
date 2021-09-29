call plug#begin()

" Theme
Plug 'junegunn/seoul256.vim'

" Language Support
Plug 'rust-lang/rust.vim'
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'plasticboy/vim-markdown'
" Plug 'mhinz/vim-crates'

" Coc (for now)
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'fannheyward/coc-rust-analyzer', {'do': 'yarn install --frozen-lockfile'}
Plug 'josa42/coc-go', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-yaml', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-eslint', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-prettier', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plug 'fannheyward/coc-styled-components', {'do': 'yarn install --frozen-lockfile'}

"Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
"Plug 'dense-analysis/ale'
"if has('nvim')
"  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"else
"  Plug 'Shougo/deoplete.nvim'
"  Plug 'roxma/nvim-yarp'
"  Plug 'roxma/vim-hug-neovim-rpc'
"endif
"Plug 'Shougo/echodoc.vim'

" Conveniences
Plug 'airblade/vim-rooter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Editor Tools
Plug 'jiangmiao/auto-pairs'  " auto add pairs for braces, parenthesis, etc
Plug 'tpope/vim-fugitive'    " Git Plugin
Plug 'tpope/vim-surround'    " Surround Editing Tool
Plug 'tpope/vim-commentary'  " Commenting
Plug 'tpope/vim-repeat'      " . Repeat for certain plugins
Plug 'tpope/vim-unimpaired'  " Shortcuts (mainly for Quickfix) 
Plug 'junegunn/vim-peekaboo' " Register Visualizer

call plug#end()

" ======================
" Plugin Settings
" ======================
" if has('nvim')
"   autocmd BufRead Cargo.toml call crates#toggle()
" endif

" Show Buffers on the top
let g:airline#extensions#tabline#enabled = 1

" Seoul Theme Mods
let g:seoul256_background = 235
colo seoul256
" unlet! g:indentLine_color_term g:indentLine_color_gui
" hi Conceal ctermfg=245

" Airline Settings 
let g:airline_theme = 'bubblegum'
let g:airline_powerline_fonts = 1
"let g:deoplete#enable_at_startup = 1
"let g:echodoc#enable_at_startup = 1
"let g:echodoc#type = 'signature'
""let g:ale_linters = {'rust': ['analyzer']}
"
"let g:LanguageClient_serverCommands = {
"    \ 'rust': ['rust-analyzer'],
"    \ }

" FZF settings
" search history
let g:fzf_history_dir = '~/.local/share/fzf-history'

" Overrides default Rg command of junegunn/fzf.  Hidden is searchable except .git
command! -bang -nargs=* Rg
	\ call fzf#vim#grep(
	\ "rg --column --line-number --no-heading --color=always --smart-case --hidden -g '!Cargo.lock' -g '!yarn.lock' --glob '!.git' -- "
	\ .shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0)

" allow ctrl-a to select all in RG search, and ctrl-q to save to quickfix
" list.  This will allow specific files to be issued commands
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'

