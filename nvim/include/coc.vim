set tagfunc=CocTagFunc

" Goto Navigation
nmap <leader>gt <Plug>(coc-type-definition)
nmap <leader>gre <Plug>(coc-references)
nmap <leader>grn <Plug>(coc-rename)
nmap <leader>gd <Plug>(coc-diagnostic-info)
nmap <leader>gp <Plug>(coc-diagnostic-prev)
nmap <leader>gn <Plug>(coc-diagnostic-next)
nmap <leader>gl <Plug>(coc-codelens-action)

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <leader>cd  :<C-u>CocList diagnostics<cr>
" Find symbol of current document
nnoremap <silent> <leader>co  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <leader>cs  :<C-u>CocList -I symbols<cr>
" list commands available
nnoremap <silent> <leader>cc  :<C-u>CocList commands<cr>
" manage extensions
nnoremap <silent> <leader>cx  :<C-u>CocList extensions<cr>
" Resume latest coc list
nnoremap <silent> <leader>cl  :<C-u>CocListResume<CR>
" restart CoC
nnoremap <silent> <leader>cR  :<C-u>CocRestart<CR>
" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" vimscript for triggering signature help for functions 
augroup mygroup
  autocmd!
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
