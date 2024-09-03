# zinit setup
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# setup oh-my-posh
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/config.toml)"

# zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# add  snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

# load completions
autoload -U compinit && compinit
zinit cdreplay -q

# keybindings
# bindkey -e
bindkey -v
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^h' backward-char
bindkey '^l' forward-char

# history
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-color "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'lsd $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'lsd $realpath'

# aliases
alias vim="nvim"
alias vi="nvim"
alias fetch="fastfetch"
alias ll="lsd -l"
alias ls="lsd"
alias lst="tree -C"
alias tas="tmux attach-session -t"
alias FHWS="fortivpn connect FHWS -u k61965 -p -s"
alias home-one="ssh max@192.168.178.65"
alias tmux attach-session="tmux attach-session -t"
alias update="sudo pacman -Syu && yay -Syu"

# shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# go path
export PATH=$PATH:$(go env GOPATH)/bin
