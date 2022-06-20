# export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:=$HOME/.config}"
# if [ -d "$XDG_CONFIG_HOME/zsh" ] ; then
#   export ZDOTDIR="${ZDOTDIR:=$XDG_CONFIG_HOME/zsh}"
# else
#   export ZDOTDIR="${ZDOTDIR:=$HOME}"
# fi
# source "$ZDOTDIR/.zshenv"
#
# Defines environment variables.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

# prezto default settings end here.
