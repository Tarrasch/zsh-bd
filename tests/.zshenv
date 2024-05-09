test -f "$TESTDIR/.zcompdump" && rm "$TESTDIR/.zcompdump"

autoload -Uz compinit && compinit

source "$TESTDIR/../bd.zsh"
export ENV_AUTHORIZATION_FILE="$PWD/.env_auth"
