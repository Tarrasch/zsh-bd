test -f "$TESTDIR/.zcompdump" && rm "$TESTDIR/.zcompdump"

source "$TESTDIR/../bd.zsh"
export ENV_AUTHORIZATION_FILE="$PWD/.env_auth"
