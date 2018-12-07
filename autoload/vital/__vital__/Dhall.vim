function! s:_vital_loaded(V) abort
  let s:JSON = vital#vital#import('Web.JSON')
endfunction

function! s:_vital_depends() abort
  return ['Web.JSON']
endfunction

function! s:read(code) abort
  try
    let json = system(printf("dhall-to-json <<< '%s'", a:code))
    return s:JSON.decode(json)
  catch /^.*:E15:/
    throw 'vital: Dhall: ' . v:exception
  endtry
endfunction

function! s:readfile(path) abort
  let detail = join(readfile(a:path), "\n")
  return s:read(detail)
endfunction
