# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Enable colors and change prompt:
autoload -U colors && colors

# Set hystory
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history
setopt append_history
setopt share_history
setopt extended_history
setopt histignorealldups    # ignore duplicates
setopt histignorespace      # ignore line starting with space

setopt auto_cd          # cd if the command is a directory
setopt longlistjobs     # display PId when suspending process
setopt notify           # report status of background jobs
setopt hash_list_all    # hash first the entire command path
setopt nohup            # don't sent SIGHUP to background process when the shell exits
setopt auto_pushd       # make cd push the old directory onto the stack
setopt nobeep
setopt pushd_ignore_dups
setopt noglobdots       # * not match dotfiles
setopt noshwordsplit    # zsh style word splitting
setopt unset            # don't error out when unset parameters are used

# support colors in less
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'


# automatic completions
autoload -U compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion::(^approximate*):*:functions' ignored-patterns '_*'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zmodload zsh/complist
compinit

# set fixed normal mode
set -o emacs

# Plugin manager
source <(antibody init)
antibody bundle < ~/.zsh_plugins.txt
source /usr/share/doc/pkgfile/command-not-found.zsh

# aliases
alias tree="exa --header --classify --long --git --tree --level=3"
alias ls="exa --classify"
alias ll="exa --classify --group --long --header --git"
alias la="exa --classify --all"
alias sl="ls"
alias v="vim"
alias gits="git status"
alias gitd="git diff"
alias gitc="git commit"
alias gita="git add"
alias gitp="git push"
alias mount_win="sudo mount /dev/nvme0n1p5 /mnt/win"

eval $(starship init zsh)
