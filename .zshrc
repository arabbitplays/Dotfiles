# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Lines configured by zsh-newuser-install

setopt autocd
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/oschdi/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall


# Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Powerlevel10k for the prompt
zinit ice depth=1; zinit light romkatv/powerlevel10k
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Load completions
autoload -U compinit && compinit

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Shell intergrations
eval "$(fzf --zsh)" # strg + r to open search through last commands
eval "$(zoxide init --cmd cd zsh)"


# History
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Aliases
alias ls="ls --color"

alias nbl="sudo nixos-rebuild switch --flake ~/.nixos#laptop"
alias nbd="sudo nixos-rebuild switch --flake ~/.nixos#desktop"
alias nu="sudo nix flake update --flake ~/.nixos"
alias nd="nix develop .#default"

alias flake="~/Resources/Flakes/flake_selector.sh"

alias cl="~/.install/clion.sh"

alias nedit="code ~/.nixos"
alias cedit="code ~/.config"

alias ga="git add ."
alias gc="git commit -m"
alias gp="git push"
alias greset="git reset --hard HEAD"

alias config="git --git-dir=$HOME/.cfg/ --work-tree=$HOME"
alias sync="~/.install/sync.sh"

alias mcstatus="systemctl status minecraft-server.service"
alias vpn="sudo openvpn --config Resources/kit.ovpn "
