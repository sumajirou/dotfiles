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

################################################################################
# PATH                                                                         
################################################################################

# for brew config
if which "/opt/homebrew/bin/brew" >/dev/null 2>&1 ; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# for WSL2 config
# Dockerに関して2,3注意を要する．
# WSL2ではWindows版のDockerを使うため，パスを通す必要がある．
# さらにcmd.exeがPATHに含まれていないといけない．環境構築時に下記コマンドを一度だけ実行する． この事情はこのファイルでなく環境構築用のスクリプトに書くべきことだがまだそれが存在しないのでここにメモしておく．
# sudo ln -s /mnt/c/Windows/System32/cmd.exe /usr/local/bin/cmd.exe
if [[ "$(uname -r)" == *microsoft* ]]; then
  export PATH="$PATH:/mnt/c/Program Files/Docker/Docker/resources/bin:/mnt/c/ProgramData/DockerDesktop/version-bin"
fi

# for anyenv
eval "$(anyenv init -)"

# for pip
export PATH=~/.local/bin:$PATH
