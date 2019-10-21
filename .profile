#
# ~/.profile
#

if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
	exec startx
fi

export QT_QPA_PLATFORMTHEME=qt5ct
export GTK_THEME=Adwaita:dark
export GTK2_RC_FILES=/usr/share/themes/Default/gtk-2.0-key/gtkrc
export GOPATH=$HOME/prog/go
export NMON=cdnmt
