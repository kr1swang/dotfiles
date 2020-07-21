" make spacebar to Leader
noremap <space> <nop>
let mapleader=" "


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

