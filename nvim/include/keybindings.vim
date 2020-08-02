" use ':verbose imap <{some_key}>' to check if a key is bound

" Make spacebar to Leader
noremap <space> <nop>
let mapleader=" "

" Turn off search highlights with Ctrl+C twice
noremap <C-c><C-c> :nohlsearch<CR>

" Jump between last two buffers 
nnoremap <leader><leader> <C-^>

" No arrow keys --- force yourself to use the home row
nnoremap <up> <nop>
nnoremap <down> <nop>
" for CoC, editing up down is enabled
" inoremap <up> <nop>
" inoremap <down> <nop>
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

" Leader Navigation for split panes
nnoremap <leader>j <C-w><C-j>
nnoremap <leader>k <C-w><C-k>
nnoremap <leader>h <C-w><C-h>
nnoremap <leader>l <C-w><C-l>

" ----------------------------
"       Plugin Specific 
" ----------------------------

" FZF Search Windows 
map <C-p> :Files<CR>
nmap <leader>; :Buffers<CR>
noremap <leader>s :Rg<CR>
