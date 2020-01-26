# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Enable colors and change prompt:
autoload -U colors && colors

# Set hystory
HISTSIZE=2000
SAVEHIST=2000
HISTFILE=~/.cache/zsh/history

# Plugin manager
source <(antibody init)
export ZSH="$(antibody home)/https-COLON--SLASH--SLASH-github.com-SLASH-robbyrussell-SLASH-oh-my-zsh"
antibody bundle < ~/.zsh_plugins.txt

# aliases
alias tree="exa --header --classify --long --git --tree --level=3"
alias ls="exa --classify"
alias ll="exa --classify --group --long --header --git"
alias la="exa --classify --all"
alias sl="ls"
alias mount_win="sudo mount /dev/nvme0n1p5 /mnt/win"

eval $(starship init zsh)
