#!/bin/bash

# -e パイプやサブシェルで実行したコマンドが1つでもエラーになったら直ちにシェルを終了する
# -u パラメーター展開中に、設定していない変数があったらエラーとする（特殊パラメーターである「@」と「*」は除く）
# -x トレース情報として、シェルが実行したコマンドとその引数を出力する。情報の先頭にはシェル変数PS4の値を使用
# -C リダイレクトで既存のファイルを上書きしない
set -euxC

# 未完成
# install brew
# install zsh
# install prezto
# install powerline10k
# brew bundle
# install fzf
eval "$(brew --prefix)/opt/fzf/install --xdg --all"
