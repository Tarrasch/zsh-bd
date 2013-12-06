Move into some folders

  $ mkdir -p a/b/c/d
  $ cd a/b/c/d

Move down to b

  $ bd b

Check that it went OK

  $ ls
  c

Now lets try to jump to folder with spaces in it

  $ mkdir -p 'a/space dir/f/g/h'
  $ cd 'a/space dir/f/g/h'
  $ bd 'space dir'
  $ ls
  f

Issue [#6] in github, `Fix error "not an identifier"`. I think the actual error
was due to OS X vs gnuutils differences. But it wont hurt to have another test
case.

  $ cd 'f/g/h'
  $ bd f
  $ ls
  g

Lets also make sure we can jump beyond a 'space dir'

  $ cd g/h
  $ bd a
  $ ls
  space dir
