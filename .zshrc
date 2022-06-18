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


###############################################################################
#
###############################################################################


###############################################################################
# pyenv
###############################################################################
# 仮想環境用のファイルは同じディレクトリに持つ．
export PIPENV_VENV_IN_PROJECT=true

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
export VISUAL=vi
export EDITOR=vi
eval "$(direnv hook zsh)"


###############################################################################
# J言語 
###############################################################################
alias jlang='docker run -it --rm nesachirou/jlang'

###############################################################################
# Python 
###############################################################################

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
alias kashi="$HOME/ghq/github.com/sumajirou/kashi/kashi.sh"

# unbuffer は色付き出力をパイプに渡すときに使う．
alias unbuffer='unbuffer '
# こう設定しておくとなぜかunbuffer に続くコマンドのエイリアスが効く．


