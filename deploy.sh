#!/usr/bin/env bash

set -eu

# dotfilesディレクトリの場所を、変数DOTFILES_DIRに教える
DOTFILES_DIR=$(cd $(dirname $0); pwd)
# dotfilesディレクトリに移動する
cd $DOTFILES_DIR

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

