# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/oschdi/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

ZSH_THEME=jnrowe

source $ZSH/oh-my-zsh.sh

alias nb="sudo nixos-rebuild switch --flake ~/Resources/Nixos-System#nixos"
alias nd="nix develop .#default"

alias nedit="code ~/Resources/Nixos-System"
alias cedit="code ~/.config"

alias ga="git add ."
alias gc="git commit -m"
alias gp="git push"
alias greset="git reset --hard HEAD"

alias config="git --git-dir=$HOME/.cfg/ --work-tree=$HOME"