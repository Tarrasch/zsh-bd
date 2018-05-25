bd () {
  (($#<1)) && {
    print -- "usage: $0 <name-of-any-parent-directory>"
    print -- "       $0 <number-of-folders>"
    return 1
  } >&2
  # example:
  #   $PWD == /home/arash/abc ==> $num_folders_we_are_in == 3
  local num_folders_we_are_in=${#${(ps:/:)${PWD}}}
  local dest="./"

  # First try to find a folder with matching name (could potentially be a number)
  # Get parents (in reverse order)
  local parents
  parents=(${(Oa)${(ps:/:)${PWD}}[1,-2]} "/")
  # Build dest and 'cd' to it
  local parent
  foreach parent (${parents})
  do
    dest+="../"
    if [[ $1 == $parent ]]
    then
      cd $dest
      return 0
    fi
  done

  # If the user provided an integer, go up as many times as asked
  local i
  dest="./"
  if [[ "$1" = <-> ]]
  then
    if [[ $1 -gt $num_folders_we_are_in ]]
    then
      print -- "bd: Error: Can not go up $1 times (not enough parent directories)"
      return 1
    fi
    for i in {1..$1}
    do
      dest+="../"
    done
    cd $dest
    return 0
  fi

  # If the above methods fail
  print -- "bd: Error: No parent directory named '$1'"
  return 1
}
_bd () {
  # Get parents (in reverse order)
  reply=(${(Oa)${(ps:/:)${PWD}}[1,-2]} "/")
}
compctl -V directories -K _bd bd
