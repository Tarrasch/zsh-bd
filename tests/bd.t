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
