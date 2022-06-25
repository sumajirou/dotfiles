#!/bin/bash

# -e パイプやサブシェルで実行したコマンドが1つでもエラーになったら直ちにシェルを終了する
# -u パラメーター展開中に、設定していない変数があったらエラーとする（特殊パラメーターである「@」と「*」は除く）
# -x トレース情報として、シェルが実行したコマンドとその引数を出力する。情報の先頭にはシェル変数PS4の値を使用
# -C リダイレクトで既存のファイルを上書きしない
set -euxC

DOTFILES_DIR=$(dirname $(readlink -f $0))

# brew の同期
brew bundle

# ドットファイルのリンク
# zsh
ln -sf "${DOTFILES_DIR}/.p10k.zsh" "${ZDOTDIR}/.p10k.zsh"
ln -sf "${DOTFILES_DIR}/.zlogin" "${ZDOTDIR}/.zlogin"
ln -sf "${DOTFILES_DIR}/.zlogout" "${ZDOTDIR}/.zlogout"
ln -sf "${DOTFILES_DIR}/.zpreztorc" "${ZDOTDIR}/.zpreztorc"
ln -sf "${DOTFILES_DIR}/.zprofile" "${ZDOTDIR}/.profile"
ln -sf "${DOTFILES_DIR}/.zshenv" "${ZDOTDIR}/.zshenv"
ln -sf "${DOTFILES_DIR}/.zshrc" "${ZDOTDIR}/.zshrc"
ln -sf "${DOTFILES_DIR}/home.zshenv" "${HOME}/.zshenv"

# nvim
ln -sf "${DOTFILES_DIR}/init.vim" "${$XDG_CONFIG_HOME}/nvim/init.vim"
ln -sf "${DOTFILES_DIR}/dein.toml" "${XDG_CONFIG_HOME}/nvim/dein.toml"
ln -sf "${DOTFILES_DIR}/dein_lazy.toml" "${XDG_CONFIG_HOME}/nvim/dein_lazy.toml"

