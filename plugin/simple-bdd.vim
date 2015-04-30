function! s:SimpleBDD() range
  for line in range(a:firstline, a:lastline)
    " Move down if necessary
    if line != a:firstline
      normal! j
    endif

    " Change first word to def and collapse whitespace
    normal! ^cwdeflcw w

    " Grab and mark the first surrounding quote character
    let l:surrounding_character = getline('.')[col('.') - 1]
    normal! ma

    " Lowercase everything between the quotes
    execute 'normal! `aguf' . l:surrounding_character

    " Remove characters that aren't alphanumeric, spaces, slashes, or hypens
    execute 'normal! `alvf' . l:surrounding_character . 'h'
    normal! :s/\%V[^a-zA-Z0-9_ /-]//ge

    " Replace spaces, slashes, and hypens with underscores
    execute 'normal! `alvf' . l:surrounding_character . 'h'
    normal! :s/\%V[ /-]\+/_/ge

    " Remove first surrounding quote
    normal! `ax

    " Remove last surrounding quote
    execute 'normal! f' . l:surrounding_character . 'x'

    " Add an 'end' on the next line
    normal! oend
  endfor
endfunction

command! -range SimpleBDD <line1>,<line2>call s:SimpleBDD()
