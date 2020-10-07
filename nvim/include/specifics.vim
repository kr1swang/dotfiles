au FileType rust runtime! include/lang/rust.vim

au FileType javascript runtime! include/lang/ts_js.vim

au FileType toml
  \ let b:Comment="#"
  \ | let b:EndComment=""
  \ | runtime! include/indent/two.vim
  \ | set indentexpr=
  \ | set smartindent

au FileType yaml
  \ let b:Comment="#"
  \ | let b:EndComment=""
  \ | runtime! include/indent/two.vim
  \ | set indentexpr=
  \ | set smartindent
