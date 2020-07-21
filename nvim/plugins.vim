call plug#begin()

" Language Support
Plug 'rust-lang/rust.vim'

" Coc (for now)
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'fannheyward/coc-rust-analyzer', {'do': 'yarn install --frozen-lockfile'}
Plug 'josa42/coc-go', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-yaml', {'do': 'yarn install --frozen-lockfile'}

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
"Plug 'airblade/vim-rooter'
"Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Git
Plug 'tpope/vim-fugitive'

call plug#end()

" ======================
" Plugin Settings
" ======================
"let g:deoplete#enable_at_startup = 1
"let g:echodoc#enable_at_startup = 1
"let g:echodoc#type = 'signature'
""let g:ale_linters = {'rust': ['analyzer']}
"
"let g:LanguageClient_serverCommands = {
"    \ 'rust': ['rust-analyzer'],
"    \ }


" Overrides default Rg command of junegunn/fzf.  Hidden is searchable except .git
command! -bang -nargs=* Rg
	\ call fzf#vim#grep(
	\ "rg --column --line-number --no-heading --color=always --smart-case --hidden --glob '!.git' -- "
	\ .shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0)
