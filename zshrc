# Created by newuser for 5.7.1
source <(antibody init)
export ZSH="$(antibody home)/https-COLON--SLASH--SLASH-github.com-SLASH-robbyrussell-SLASH-oh-my-zsh"
antibody bundle < ~/.zsh_plugins.txt

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

alias tree="exa --header --classify --long --git --tree --level=3"
alias ls="exa --across --classify"
alias ll="exa --classify --group --long --header --git"
alias sl="ls"
alias mount_win="sudo mount /dev/nvme0n1p5 /mnt/win"
#alias cdl="cd $0; ls"
