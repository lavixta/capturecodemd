command! -bar -bang Capturecode call s:Capturecode()
" command! -bar CheatsheetEdit lua require'cheatsheet.utils'.edit_user_cheatsheet()

function! s:Capturecode()
  " bang command
  " if a:force_float
    lua require('capturecodemd').show_md_files()
  " else
  "   lua require('capturecodemd').show_md_files()
  " endif
endfunction
