bd () {
  (($#<1)) && {
    print -- "usage: $0 <name-of-any-parent-directory>"
    return 1
  } >&2
  parents=(${=PWD//\// })
  dest="./"
  foreach parent (${(Oa)parents}) # Loop backwards
  do
    if [[ $1 == $parent ]]
    then
      cd $dest
      return 0
    fi
    dest+="../"
  done
  print -- "bd: Error: No parent directory named '$1'"
  return 1
}

_bd () {
  temp=(${=PWD//\// })
  for e in "${temp[@]}"; do
    reply=("$e" "${reply[@]}")
  done
}
compctl -V directories -K _bd bd
