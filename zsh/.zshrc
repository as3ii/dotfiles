# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Enable colors and change prompt:
autoload -U colors && colors

# Set hystory
HISTSIZE=200000
SAVEHIST=1000000
HISTFILE=~/.cache/zsh/history
setopt append_history
setopt share_history
setopt extended_history
setopt histignorealldups    # ignore duplicates
setopt histignorespace      # ignore line starting with space

setopt auto_cd          # cd if the command is a directory
setopt longlistjobs     # display PID when suspending process
setopt notify           # report status of background jobs
setopt hash_list_all    # hash first the entire command path
setopt nohup            # don't sent SIGHUP to background process when the shell exits
setopt auto_pushd       # make cd push the old directory onto the stack
setopt nobeep
setopt pushd_ignore_dups
setopt noglobdots       # * not match dotfiles
setopt noshwordsplit    # zsh style word splitting
setopt unset            # don't error out when unset parameters are used
setopt interactivecomments  # accept comments on interactive shell
setopt completeinword   # complete not just at the end

# automatic completions
autoload -U compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion::(^approximate*):*:functions' ignored-patterns '_*'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zmodload zsh/complist
compinit -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_BERSION

# set fixed normal mode
bindkey -e
# Keybinding:
autoload -U zkbd
[[ ! -f ${ZDOTDIR:-$HOME}/.zkbd/$TERM ]] && zkbd
[[ -f ${ZDOTDIR:-$HOME}/.zkbd/$TERM ]] && source ${ZDOTDIR:-$HOME}/.zkbd/$TERM
[[ -n ${key[Backspace]} ]] && bindkey "${key[Backspace]}" backward-delete-char
[[ -n ${key[Insert]} ]] && bindkey "${key[Insert]}" overwrite-mode
[[ -n ${key[Home]} ]] && bindkey "${key[Home]}" beginning-of-line
[[ -n ${key[Delete]} ]] && bindkey "${key[Delete]}" delete-char
[[ -n ${key[End]} ]] && bindkey "${key[End]}" end-of-line
[[ -n ${key[Up]} ]] && bindkey "${key[Up]}" up-line-or-search
[[ -n ${key[Left]} ]] && bindkey "${key[Left]}" backward-char
[[ -n ${key[Down]} ]] && bindkey "${key[Down]}" down-line-or-search
[[ -n ${key[Right]} ]] && bindkey "${key[Right]}" forward-char

# Plugin manager
source <(antibody init)
antibody bundle < "${ZDOTDIR:-$HOME}/.zsh_plugins.txt"
source /usr/share/doc/pkgfile/command-not-found.zsh
[[ -s "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/grc.zsh" ]] && \
    source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/grc.zsh"

# functions
sleepuntil() {
    now=$(date +%s)
    target=$(date -d "$1" +%s)
    diff=$(( $target - $now ))
    if [ $diff -gt 0 ]; then
        printf "Sleeping for %ss\n" "$diff"
        sleep "$diff"
        return 0
    else
        printf "Target date/hours passed\n"
        return 1
    fi
}

# aliases
alias grep="grep --color=auto"
alias ip="ip -c"
alias tree="exa --tree --level=4"
alias ls="exa --classify"
alias ll="exa --classify --group --long --header --git"
alias la="exa --classify --all"
alias sl="ls"
alias :q="exit"
alias cp="cp --reflink=auto -i"
alias mv="mv -i"
alias vim="nvim"
alias v="vim"
alias cls="clear"
alias gits="git status"
alias gitd="git diff"
alias gitc="git commit -S"
alias gita="git add"
alias gitp="git push"
alias gitg="setsid gitg &"
alias mount_win="sudo mount /dev/nvme0n1p5 /mnt/win"
alias open="xdg-open"
alias scrub_start="sudo btrfs scrub start /"
alias scrub_stat="sudo btrfs scrub status /"
alias defrag="sudo btrfs filesystem defragment -rf -czstd /"
alias format="clang-format --style=\"{BasedOnStyle: llvm, IndentWidth: 4}\" -i *.cpp *.h *.cc *.c"
alias ssh="TERM=xterm-256color ssh"
alias ssh-nohost="ssh -o 'UserKnownHostsFile=/dev/null'"
alias docker="podman"
alias docker-compose="podman-compose"
alias clippy="cargo clean; cargo fmt --all; cargo clippy -- -W clippy::pedantic"
alias paru="nice -n 20 paru"
mpva() {
    case "$1" in
        *.m3u|*.m3u8) playlist="$1"; shift
            mpv --no-config --no-video --no-cookies --ao=jack \
            --audio-channels=2 --cache=yes --playlist="$playlist" $@;;
        *) mpv --no-config --no-video --no-cookies --ao=jack \
            --audio-channels=2 --cache=yes $@;;
    esac
}
mpv() {
    case "$1" in
        *.m3u|*.m3u8) playlist="$1"; shift
            /usr/bin/mpv --playlist="$playlist" $@;;
        *) /usr/bin/mpv $@;;
    esac
}
meteo() {
    curl https://wttr.in/"$1"
}

eval $(thefuck --alias)
alias f="fuck"

eval $(starship init zsh)

# SSH agent
env=~/.ssh/agent.env

agent_load_env () { test -f "$env" && . "$env" >| /dev/null ; }

agent_start () {
    (umask 077; ssh-agent >| "$env")
    . "$env" >| /dev/null ; }

agent_load_env

# agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2=agent not running
agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)

if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
    agent_start
    ssh-add ~/.ssh/id_rsa-debertolis_lorenzo
elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
    ssh-add ~/.ssh/id_rsa-debertolis_lorenzo
fi

unset env

