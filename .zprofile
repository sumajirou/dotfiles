# Executes commands at login pre-zshrc.


####################################################################################################
# Browser
####################################################################################################
if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

####################################################################################################
# Editors
####################################################################################################
export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'

####################################################################################################
# Language
####################################################################################################
if [[ -z "$LANG" ]]; then
  export LANG='ja_JP.UTF-8'
fi

####################################################################################################
# Paths
####################################################################################################

# パスの重複を禁じる(Ensure path arrays do not contain duplicates.)
typeset -gU cdpath fpath mailpath path

# Set the list of directories that cd searches.
# cdpath=(
#   $cdpath
# )

# Set the list of directories that Zsh searches for programs.
# echo $path #=> /usr/local/bin /usr/bin /bin /usr/sbin /sbin
path=(
  /usr/local/{bin,sbin}
  $path
)

####################################################################################################
# Less
####################################################################################################

# lessのデフォルトオプション
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
# -F    一画面で表示できる場合はすぐに終了する
# -g	検索したとき、ヒットした全ての文字列を反転するのではなく、現在カーソルがある行のみ反転する。
# -i	検索時に全部小文字で入力したときだけ、大文字小文字を無視する。
# -M	詳しいプロンプトを表示する。
# -R	ANSI カラーエスケープシーケンスを解するようになる。
# -S	一行が長く、ターミナルの幅が狭くて表示できない場合、途中までしか表示しない。
# -w	一度に2行以上移動した場合、新たに表示した最初の行をハイライトする。
# -X    終了時表示内容が画面上に残る
# -z-4	ウィンドウのサイズ(CTRL-Fで動く行数)をターミナルのサイズ - 4 に設定する。
export LESS='-F -g -i -M -R -S -w -X -z-4'

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
# (lesspipeはbatがあれば不要)
if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi
