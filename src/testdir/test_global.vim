
func Test_yank_put_clipboard()
  new
  call setline(1, ['a', 'b', 'c'])
  set clipboard=unnamed
  g/^/normal yyp
  call assert_equal(['a', 'a', 'b', 'b', 'c', 'c'], getline(1, 6))

  set clipboard&
  bwipe!
endfunc

func Test_nested_global()
  new
  call setline(1, ['nothing', 'found', 'found bad', 'bad'])
  call assert_fails('g/found/3v/bad/s/^/++/', 'E147')
  g/found/v/bad/s/^/++/
  call assert_equal(['nothing', '++found', 'found bad', 'bad'], getline(1, 4))
  bwipe!
endfunc

func Test_global_error()
  call assert_fails('g\\a', 'E10:')
  call assert_fails('g', 'E148:')
  call assert_fails('g/\(/y', 'E476:')
endfunc

" vim: shiftwidth=2 sts=2 expandtab
