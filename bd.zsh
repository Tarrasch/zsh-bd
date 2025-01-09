# shellcheck shell=bash
bd () {
  (($#<1)) && {
    printf -- 'usage: %s <name-of-any-parent-directory>\n' "${0}"
    printf -- '       %s <number-of-folders>\n' "${0}"

    return 1
  } >&2

  local requestedDestination="${1}"
  local -a parents=(${(ps:/:)"${PWD}"})
  local numParents
  local dest
  local i
  local parent

  # prepend root to the parents array
  parents=('/' "${parents[@]}")

  # Remove the current directory since it isn't a parent
  shift -p parents

  # Get the number of parent directories
  numParents="$(( ${#parents[@]}))"

  # Build dest and 'cd' to it by looping over the parents array in reverse
  dest='./'
  for i in $(seq "${numParents}" -1 1); do
    parent="${parents[${i}]}"
    dest+='../'

    if [[ "${requestedDestination}" == "${parent}" ]]; then
      cd $dest

      return $?
    fi
  done

  # If the user provided an integer, go up as many times as asked
  dest='./'
  if [[ "${requestedDestination}" == <-> ]]; then
    if [[ "${requestedDestination}" -gt "${numParents}" ]]; then
      printf -- '%s: Error: Can not go up %s times (not enough parent directories)\n' "${0}" "${requestedDestination}"
      return 1
    fi

    for i in {1.."${requestedDestination}"}; do
      dest+='../'
    done

    cd "${dest}"

    return $?
  fi

  # If the above methods fail
  printf -- '%s: Error: No parent directory named "%s"\n' "${0}" "${requestedDestination}"
  return 1
}

_bd () {
  # Get parents (in reverse order)
  local localMatcherList
  local -a parents=(${(ps:/:)"${PWD}"})
  local numParents
  local i
  local -a parentsReverse

  zstyle -s ':completion:*' 'matcher-list' 'localMatcherList'

  # prepend root to the parents array
  parents=('/' "${parents[@]}")

  # Remove the current directory since it isn't a parent
  shift -p parents

  # Get the number of parent directories
  numParents="$(( ${#parents[@]}))"

  parentsReverse=()
  for i in $(seq "${numParents}" -1 1); do
    parentsReverse+=("${parents[${i}]}")
  done

  local expl
  _wanted -V directories expl 'parent directories' \
    compadd -M "${localMatcherList}" "$@" -- "${parentsReverse[@]}"
}

compdef _bd bd

() {
  local -a colors
  local dir_color='1;31' # hard-coded default in zsh/complist

  # check for defined zstyle
  if zstyle -a ':completion:*' list-colors colors && [[ "$#colors" -ne 0 ]]; then
    local zstyle_color="${colors[(r)di=*]#di=}"
    if [[ -n "$zstyle_color" ]]; then
        dir_color="$zstyle_color"
    fi
  else
    return
  fi

  zstyle ':completion:*:*:bd:*:directories' list-colors "=*=${dir_color}"
}
