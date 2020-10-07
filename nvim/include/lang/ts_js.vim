" force language server to parse with jsx on ts/js files
" by default, they need to be .tsx and .jsx
" augroup filetype_jsx
"     autocmd!
"     autocmd FileType javascript set filetype=javascriptreact
"     autocmd FileType typescript set filetype=typescriptreact
" augroup END

" force rescan syntax on highlight because of out of sync jsx
autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear
