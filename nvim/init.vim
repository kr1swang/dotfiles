" ----------------------------
"           Imports 
" ----------------------------

runtime! plugins.vim
runtime! include/keybindings.vim
runtime! include/specifics.vim
runtime! include/coc.vim

" todo, https://tinyheero.github.io/2017/11/04/vim-cheatsheet.html add
" cheatsheet so that you don't forget like a braised tongue

" ----------------------------
"         Vim Settings
" ----------------------------

if has('nvim')
"    set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
    set inccommand=nosplit
end

" https://vi.stackexchange.com/questions/10124/what-is-the-difference-between-filetype-plugin-indent-on-and-filetype-indent
filetype plugin indent on

set updatetime=300         " better performance according to CoC
set cmdheight=1            " : command bottom bar height 
set autoindent             " enable indentation 
set shiftwidth=4           " set indenting spaces 
set tabstop=4              " set tab spaces 
set nowrap
set encoding=utf-8
set hidden                 " hides instead of closes buffers, important for plugins
set scrolloff=5
set noshowmode             " Turns off Vim Mode Display because lightline plugin already handles it
set number                 " shows absolute number at cursor
set relativenumber
set colorcolumn=100 
set signcolumn=yes         " Always draw sign column. Prevent buffer moving when adding/deleting sign.
set showcmd                " Show (partial) command in status line.
set mouse=a                " Enable mouse usage (all modes) in terminal

" Make diffing better: https://vimways.org/2018/the-power-of-diff/
set diffopt+=iwhite " No whitespace in vimdiff
set diffopt+=algorithm:patience
set diffopt+=indent-heuristic
set timeoutlen=500 " http://stackoverflow.com/questions/2158516/delay-before-o-opens-a-new-line
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

" Terminal Color Settings
if !has('gui_running')
  set t_Co=256
endif
if (match($TERM, "-256color") != -1) && (match($TERM, "screen-256color") == -1)
  " screen does not (yet) support truecolor
  set termguicolors
endif

" disable .netrwhist file
" https://stackoverflow.com/questions/9850360/what-is-netrwhist
let g:netrw_dirhistmax = 0

" solarized, woodland, twilight, -gruvbox-dark-pale <--- things to try
