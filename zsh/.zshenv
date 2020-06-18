export EDITOR="nvim"
export READER="zathura"
export VISUAL="nvim"
export CODEEDITOR="nvim"
export TERMINAL="alacritty"
export BROWSER="firefox"
export COLORTERM="truecolor"
export PAGER="less"
export WM="bspwm"
export READER="zathura"

# color in less
export LESS=-R
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
export LESSOPEN="| /usr/bin/highlight -O ansi %s 2>/dev/null"

export QT_QPA_PLATFORMTHEME=qt5ct
export GTK_THEME=Adwaita:dark
export NMON=cdnmt
export FZF_DEFAULT_OPTS=-e

# ~/ Clean-up
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

#export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
#export GTK2_RC_FILES="${XDG_CONFIG_HOME:-$HOME/.config}/gtk-2.0/gtkrc-2.0"
export GTK2_RC_FILES=/usr/share/themes/Default/gtk-2.0-key/gtkrc
export LESSHISTFILE="-"
export WGETRC="${XDG_CONFIG_HOME:-$HOME/.config}/wget/wgetrc"
export INPUTRC="${XDG_CONFIG_HOME:-$HOME/.config}/inputrc"
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
#export GNUPGHOME="$XDG_DATA_HOME/gnupg"
#export WINEPREFIX="${XDG_DATA_HOME:-$HOME/.local/share}/wineprefixes/default"
export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"
#export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"
export GOPATH=$HOME/prog/go
export ANSIBLE_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/ansible/ansible.cfg"
export HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/history"
export CCACHE_DIR="$XDG_CACHE_HOME"/ccache
export XINITRC="$XDG_CONFIG_HOME"/xinitrc
export HISTFILE="${XDG_CACHE_HOME}/bash_history"
