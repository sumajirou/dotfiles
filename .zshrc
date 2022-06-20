# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
# prezto default settings end here.

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
if [[ -s "${ZDOTDIR:-$HOME}/.p10k.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.p10k.zsh"
fi

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
# WSL2 Dockerに関して少し注意を要する。 WSL2ではWindows版のDockerを使うため，パスを通す必要がある。
# さらにcmd.exeがPATHに含まれていないといけない．環境構築時に下記コマンドを一度だけ実行する． この事情はこのファイルでなく環境構築用のスクリプトに書くべきことだがまだそれが存在しないのでここにメモしておく．
# 
if [[ "$(uname -r)" == *microsoft* ]]; then
  export PATH="$PATH:/mnt/c/Program Files/Docker/Docker/resources/bin:/mnt/c/ProgramData/DockerDesktop/version-bin"
  if [ ! -e /usr/local/bin/cmd.exe ]; then
    ln -s /mnt/c/Windows/System32/cmd.exe /usr/local/bin/cmd.exe
  fi
fi

# for asdf
export ASDF_CONFIG_FILE="$XDG_CONFIG_HOME/asdf/.asdfrc"
export ASDF_DATA_DIR="$XDG_DATA_HOME/asdf"
. "$(brew --prefix asdf)/libexec/asdf.sh"

###############################################################################
# alias
###############################################################################

# lsの代わりにexaを使う．基本はls, la, llで事足りるだろう．サイズor更新日時or拡張子の昇順で並び替えるコマンドも用意．lllは全部盛りだが使う機会は見当たらない．
alias ls='exa --group-directories-first --time-style=long-iso --git'
alias la='ls -a'
alias ll='ls -al'
alias lls='ll -s size'
alias llt='ll -s modified'
alias lle='ll -s extension'
alias lll='ll -ghHiS'

# 環境変数PATHを整形して表示
alias printpath='printenv PATH | tr : \\n'
# 設定の再読み込み
alias relogin='exec -l $SHELL'
# neovim
alias vi='nvim'
alias vim='nvim'
###############################################################################
# fzf 
###############################################################################
# installスクリプトの結果．キーバインドのCTRL+R, CTRL+T, ALT+Cの追加．
# C-Rは最近のコマンド, C-Tはファイルの候補, A-Cはディレクトリの直接移動
# C-Gはghqで一括管理しているgitリポジトリへの移動
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_COMMAND='fd --hidden --follow --exclude "{node_modules,.git}"'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND} --type f"
# export FZF_CTRL_T_OPTS=
# export FZF_CTRL_R_OPTS=
export FZF_ALT_C_COMMAND="${FZF_DEFAULT_COMMAND} --type d"
# export FZF_ALT_C_OPTS=


function __cd_ghq_list() {
  local BUF=$BUFFER
  zle kill-whole-line
  # cd $(ghq root)/$(ghq list | fzf -q "$BUF")
  cd $(ghq list --full-path| fzf -q "$BUF")
  # zle -U $BUF
  zle .accept-line
}
zle -N __cd_ghq_list
bindkey '^G' __cd_ghq_list

# 野望
# カレントディレクトリのファイルやディレクトリは先頭に表示してほしいよね！
# bat を使って中身のpreviewするコマンドもほしいな．あれば十分ファイラの代わりになる

###############################################################################
# kubectl 
###############################################################################

# kubectl の補完を有効化
source <(kubectl completion zsh)

# alias
alias k='kubectl'
alias kg='kubectl get'
alias kgall='kubectl get all -o wide'
alias kaf='kubectl apply -f'
alias kdf='kubectl delete -f'
# Dockerイメージのタグを一覧取得する
function dtags {
  curl -s https://registry.hub.docker.com/v1/repositories/$1/tags | jq -r '.[].name'
}

###############################################################################
# direnv 
###############################################################################
export VISUAL=nvim
export EDITOR=nvim
eval "$(direnv hook zsh)"

###############################################################################
# J言語 
###############################################################################
alias jlang='docker run -it --rm nesachirou/jlang'

###############################################################################
# ネットワーク関係
###############################################################################
alias ip='ip -color=auto'

###############################################################################
# 
###############################################################################

###############################################################################
# 便利
###############################################################################

###############################################################################
# 一時的な設定 
###############################################################################
# 歌詞表示CLIツール
alias kashi='docker run --rm -it sumajirou/kashi:latest'
# unbuffer は色付き出力をパイプに渡すときに使う．こう設定しておくとなぜかunbuffer に続くコマンドのエイリアスが効く．
alias unbuffer='unbuffer '
