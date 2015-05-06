function! s:SimpleBDD() range
  let l:simple_bdd_keywords = '\(Given\|When\|Then\|And\|Also\|But\|given\|when\|then\|and\|also\|but\)'
  let l:count = 0

  for l:line_number in range(a:firstline, a:lastline)
    let l:line = matchstr(getline(l:line_number + l:count), ' *' . l:simple_bdd_keywords . ' ')
    if empty(l:line)
      normal! j
      continue
    endif

    " Move down if necessary
    if l:count > 0
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

    let l:count += 1
  endfor

  if a:firstline == a:lastline
    " Begin inserting inside above the current line
    call feedkeys('O')
  endif
endfunction

command! -range SimpleBDD <line1>,<line2>call s:SimpleBDD()
