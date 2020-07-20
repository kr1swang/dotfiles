noremap <SPACE> <nop>
let mapleader=" "

" ======================
" Plugins
" ======================

call plug#begin()

" Language Support
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
Plug 'dense-analysis/ale'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" Conveniences
Plug 'airblade/vim-rooter'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()

" ======================
" Plugin Settings
" ======================
let g:deoplete#enable_at_startup = 1
"let g:ale_linters = {'rust': ['analyzer']}

"let g:LanguageClient_serverCommands = {
"    \ 'rust': ['rust-analyzer'],
"    \ }


" Overrides default Rg command of junegunn/fzf.  Hidden ok except .git
command! -bang -nargs=* Rg
	\ call fzf#vim#grep(
	\ "rg --column --line-number --no-heading --color=always --smart-case --hidden --glob '!.git' -- "
	\ .shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0)


" ======================
" Editor Settings
" ======================

if has('nvim')
"    set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
    set inccommand=nosplit
end

" https://vi.stackexchange.com/questions/10124/what-is-the-difference-between-filetype-plugin-indent-on-and-filetype-indent
filetype plugin indent on
set autoindent " Turns off Vim Mode Display because lightline plugin already handles it
set nowrap
set encoding=utf-8
set hidden " hides instead of closes buffers
set scrolloff=5
set noshowmode
set number " shows absolute number at cursor
set relativenumber
set colorcolumn=100 
set signcolumn=yes " Always draw sign column. Prevent buffer moving when adding/deleting sign.
set showcmd " Show (partial) command in status line.
set mouse=a " Enable mouse usage (all modes) in terminal
" Make diffing better: https://vimways.org/2018/the-power-of-diff/
set diffopt+=iwhite " No whitespace in vimdiff
set diffopt+=algorithm:patience
set diffopt+=indent-heuristic
set timeoutlen=300 " http://stackoverflow.com/questions/2158516/delay-before-o-opens-a-new-line
set nojoinspaces " https://stackoverflow.com/questions/1578951/why-does-vim-add-spaces-when-joining-lines

" Nicer split panes
set splitright
set splitbelow

" Permanent undo
set undodir=~/.vimdid
set undofile

if executable('rg')
	set grepformat=%f:%l:%c:%m
	set grepprg=rg\ --no-heading\ --vimgrep
endif

" ======================
" Key Mappings and Hotkeys
" ======================

" Jump between files 
nnoremap <leader><leader> <c-^>

" Rg shortcut 
noremap <leader>s :Rg<CR>
" use this to search files rg --files --hidden --follow --g '!.git'


" Open hotkeys
map <C-p> :Files<CR>
nmap <leader>; :Buffers<CR>

" No arrow keys --- force yourself to use the home row
nnoremap <up> <nop>
nnoremap <down> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Left and right can switch buffers
nnoremap <left> :bp<CR>
nnoremap <right> :bn<CR>

" Move by line (wrapped lines are counted)
nnoremap j gj
nnoremap k gk

" Ctrl-C as Escape
nnoremap <C-c> <Esc>
inoremap <C-c> <Esc>
vnoremap <C-c> <Esc>
snoremap <C-c> <Esc>
xnoremap <C-c> <Esc>
cnoremap <C-c> <Esc>
onoremap <C-c> <Esc>
lnoremap <C-c> <Esc>
tnoremap <C-c> <Esc>

" ======================
" Colors and Themes
" ======================
if !has('gui_running')
  set t_Co=256
endif
if (match($TERM, "-256color") != -1) && (match($TERM, "screen-256color") == -1)
  " screen does not (yet) support truecolor
  set termguicolors
endif
