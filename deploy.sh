#!/bin/sh 
set -eu

brew bundle

ln -sf "${HOME}/ghq/github.com/sumajirou/dotfiles/.p10k.zsh" "${ZDOTDIR}/.p10k.zsh"
ln -sf "${HOME}/ghq/github.com/sumajirou/dotfiles/.zlogin" "${ZDOTDIR}/.zlogin"
ln -sf "${HOME}/ghq/github.com/sumajirou/dotfiles/.zlogout" "${ZDOTDIR}/.zlogout"
ln -sf "${HOME}/ghq/github.com/sumajirou/dotfiles/.zpreztorc" "${ZDOTDIR}/.zpreztorc"
ln -sf "${HOME}/ghq/github.com/sumajirou/dotfiles/.zprofile" "${ZDOTDIR}/.profile"
ln -sf "${HOME}/ghq/github.com/sumajirou/dotfiles/.zshenv" "${ZDOTDIR}/.zshenv"
ln -sf "${HOME}/ghq/github.com/sumajirou/dotfiles/.zshrc" "${ZDOTDIR}/.zshrc"
ln -sf "${HOME}/ghq/github.com/sumajirou/dotfiles/home.zshenv" "${HOME}/.zshenv"

ln -sf "${HOME}/ghq/github.com/sumajirou/dotfiles/init.vim" "${$XDG_CONFIG_HOME}/nvim/init.vim"
ln -sf "${HOME}/ghq/github.com/sumajirou/dotfiles/dein.toml" "${XDG_CONFIG_HOME}/nvim/dein.toml"
ln -sf "${HOME}/ghq/github.com/sumajirou/dotfiles/dein_lazy.toml" "${XDG_CONFIG_HOME}/dein_lazy.toml"

