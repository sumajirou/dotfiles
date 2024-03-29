# p10kのインスタントプロンプト機能の有効化(.zshrcの先頭に書きましょう)
# Zshを起動すると即座にプロンプトが表示されプラグインがロードされている間に入力を開始することができる。
# コンソールからの入力を必要とする初期化コード(パスワードプロンプトや[y/n]確認など)はこのブロックの上に置く必要がある。
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Preztoのロード .zpreztoはここで読み込まれる
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
    source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# p10kのロード
# `p10k configure`か${ZDOTDIR}/.p10k.zshを編集することでプロンプトをカスタマイズできる
if [[ -s "${ZDOTDIR:-$HOME}/.p10k.zsh" ]]; then
    source "${ZDOTDIR:-$HOME}/.p10k.zsh"
fi



# zsh設定メモ
#
# 設定ファイルの読み込み順
# ログインシェルの場合
# 1.  /etc/zshenv
# 2.  ${ZDOTDIR:-$HOME}/.zshenv
# 3.  /etc/zprofile
# 4.  ${ZDOTDIR:-$HOME}/.zprofile
# 5.  /etc/zshrc
# 6.  ${ZDOTDIR:-$HOME}/.zshrc
# 7.  ${ZDOTDIR:-$HOME}/.zpreztorc (正確には.zshrcの中のpreztoのinitの中で読み込まれる)
# 8.  /etc/zlogin
# 9.  ${ZDOTDIR:-$HOME}/.zlogin
# 10. ${ZDOTDIR:-$HOME}/.zlogout
# 11. /etc/zlogout
#
# インタラクティブシェルの場合（iterm2上でbashやzshと打った場合）
# 1.  /etc/zshenv
# 2.  ~/.zshenv
# 3.  /etc/zshrc
# 4.  ~/.zshrc
#
# シェルスクリプト実行の場合
# 1.  /etc/zshenv
# 2.  ~/.zshenv
#
# zshenvは全てのインスタンスで使用されるためできるだけ小さく保つ。環境変数のみを定義する。
# zprofileはzloginと似ているが、zshrcの前に読み込まれる。
# zloginはログイン時のみ実行される。zshrcの後に読み込まれる。設定を変えるのには使わず、メッセージの出力やファイルの作成に使う
# zlogoutはログアウト時に実行される。メッセージの出力やファイルの削除に使う。



################################################################################
# PATH
################################################################################
# 自作のスクリプトや拾ったスクリプトを置く場所
export PATH="$HOME/bin:$PATH"

# zsh補完ファイル置き場をfpathに追加
[ ! -e "${ZDOTDIR}/completions" ] && mkdir -p "${ZDOTDIR}/completions"
fpath=( "${ZDOTDIR}/completions" "${fpath[@]}" )


# for brew config
if which "/opt/homebrew/bin/brew" >/dev/null 2>&1 ; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi
# 補完ファイルの読み込み brewでインストールしたコマンドで対応しているものの補完が有効になる
fpath=( "$(brew --prefix)/share/zsh/site-functions" "${fpath[@]}" )

# for WSL2 docker config
if [[ "$(uname -r)" == *microsoft* ]]; then
    # export PATH="$PATH:/mnt/c/Program Files/Docker/Docker/resources/bin:/mnt/c/ProgramData/DockerDesktop/version-bin"
    export PATH="$PATH:/mnt/c/Program Files/Docker/Docker/resources/bin"
    if [ ! -e /usr/local/bin/cmd.exe ]; then
        ln -s /mnt/c/Windows/System32/cmd.exe /usr/local/bin/cmd.exe
    fi
fi

# for asdf
export ASDF_CONFIG_FILE="$XDG_CONFIG_HOME/asdf/.asdfrc"
export ASDF_DATA_DIR="$XDG_DATA_HOME/asdf"
. "$(brew --prefix asdf)/libexec/asdf.sh"

# for deno
if [ ! -s "${ZDOTDIR}/completions/_deno" ]; then
    deno completions zsh >! "${ZDOTDIR}/completions/_deno"
fi


# 補完ファイルの読み込み
autoload -Uz compinit && compinit





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
alias tree='ll --tree'

# 環境変数PATHを整形して表示
alias printpath='printenv PATH | tr : \\n'
# 設定の再読み込み
alias relogin='exec -l $SHELL'
# neovim
alias vi='nvim'
alias vim='nvim'

# vimdiff
alias vimdiff='nvim -d'

###############################################################################
# fzf
###############################################################################
# fzfのkey-binding.zshは読み込むが、キーバインドは無効化する
[ -f "${XDG_CONFIG_HOME}"/fzf/fzf.zsh ] && source "${XDG_CONFIG_HOME}"/fzf/fzf.zsh
bindkey -r '^T'
bindkey -r '^R'
bindkey -r '\ec'
bindkey -e

# * (CTRL-T)ディレクトリ移動用コマンド
# * (CTRL-F)ファイル名補完用コマンド
# * (CTRL-R)コマンド履歴

# ファイル検索にfdを使い、.gitignoreのファイルを無視し、隠しファイルを含め、シンボリックリンクをたどり、node_modulesと.gitを無視する
export FZF_DEFAULT_COMMAND='fd --hidden --follow --exclude "{node_modules,.git}"'
export FZF_DEFAULT_OPTS='--height=40% --layout=reverse --border=rounded'

# ファイル名・フォルダ名の補完
# export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND} --absolute-path --base-directory ~"
export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
export FZF_CTRL_T_OPTS="--preview 'mypreview.sh {} | head -200'"
# fzfをLANG=Cで実行する。さもないとpreviewのレイアウトが崩れる
function fzf-file-widget-langc(){
LANG=C zle fzf-file-widget
}
zle -N fzf-file-widget-langc
bindkey '^F' fzf-file-widget-langc

# コマンド履歴
export FZF_CTRL_R_OPTS=""
bindkey '^R' fzf-history-widget

# ディレクトリ移動
export FZF_ALT_C_COMMAND="${FZF_DEFAULT_COMMAND} --type d"
export FZF_ALT_C_OPTS="${FZF_DEFAULT_OPTS} --preview 'exa --tree {} | head -200' --select-1 --exit-0"
# fzfをLANG=Cで実行する。さもないとpreviewのレイアウトが崩れる
function fzf-cd-widget-langc(){
LANG=C zle fzf-cd-widget
}
zle -N fzf-cd-widget-langc
bindkey '^T' fzf-cd-widget-langc

# C-Gはghqで一括管理しているgitリポジトリへの移動
function __cd_ghq_list() {
    local BUF=$BUFFER
    zle kill-whole-line
    # cd $(ghq root)/$(ghq list | fzf -q "$BUF")
    cd $(ghq list --full-path| fzf -q "$BUF")
    zle .accept-line
}
zle -N __cd_ghq_list
bindkey '^G' __cd_ghq_list

# 全文検索(未完成)
# 検索して出てきたものをどうするか
# * エディタで開く
# * 行を出力する
# * ファイル名を出力する
# 色々できるようにするのはいいと思うんだけどvim内でやったほうが早くね？
function fzf-rg-widget(){
    RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "
    INITIAL_QUERY=""
    local output
    output=$(FZF_DEFAULT_COMMAND="$RG_PREFIX '$INITIAL_QUERY'" fzf --bind "change:reload:$RG_PREFIX {q} || true" --ansi --phony --query "$INITIAL_QUERY" | cut -d':' -f 1)
    local ret=$?
    LBUFFER="${LBUFFER}${output}"
    zle reset-prompt
    return $ret
}
zle -N fzf-rg-widget
bindkey '^S' fzf-rg-widget

# ヒント1
# ;で区切って標準出力にまとめて出してから fzfにパイプしてやると複数のコマンドの実行結果を渡せる。
# ヒント2
# --headerで入力行とカウント行の下にヘッダを入力できる。
# --header-linesで指定した数字分だけアイテムが選択不可能になりヘッダと同じ表示になる
# (date; ps -ef) |
#   fzf --bind='ctrl-r:reload(date; ps -ef)' \
#       --header=$'Press CTRL-R to reload\n\n' --header-lines=2 \
#       --preview='echo {}' --preview-window=down,3,wrap \
#       --layout=reverse --height=80% | awk '{print $2}' | xargs kill -9

# 案1　カレントディレクトリ以下の内容+ホーム以下の内容+ルート以下の内容のように順番に表示する
# 案2　何らかのキーで案1の3つを順々に切り替えられるようにする。
# どちらにせよパイプは使わずDEFAULTCOMMANDで。
# To work around the issues, we set $FZF_DEFAULT_COMMAND to the initial find command, so fzf can start the process and kill it when it has to.
# FZF_DEFAULT_COMMAND='find . -type f' fzf --bind 'ctrl-d:reload(find . -type d),ctrl-f:reload($FZF_DEFAULT_COMMAND)'
# https://github.com/junegunn/fzf/blob/master/ADVANCED.md
# https://github.com/junegunn/fzf/issues/1750







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
# その他
###############################################################################
# tldr
# . "/opt/homebrew/Cellar/tldr/1.4.3/share/zsh/site-functions/_tldr"
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
