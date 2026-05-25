# https://specifications.freedesktop.org/basedir/latest/
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

eval "$(/opt/homebrew/bin/brew shellenv)"

export EDITOR="nvim"
export VISUAL="nvim"

export HISTFILE=$HOME/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000

setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

setopt EXTENDED_GLOB

# GNU coreutils instead of macOS BSD versions (ls, cp, mv, etc.)
# (may break some builds like GMP; use clean PATH if needed)
# export PATH="$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin:$PATH"

# curl
export PATH="/opt/homebrew/opt/curl/bin:$PATH"

# mise
eval "$(mise activate zsh)"

# atuin
eval "$(atuin init zsh)"

# zoxide
eval "$(zoxide init zsh)"

# carapace
autoload -U compinit && compinit
export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense'
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
source <(carapace _carapace)

# starship
export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml
eval "$(starship init zsh)"

# orbstack cli integration
if [ -f "$HOME/.orbstack/shell/init.zsh" ]; then
  source "$HOME/.orbstack/shell/init.zsh"
fi

# zsh-autosuggestions
source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# zsh-syntax-highlighting
source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# aliases
stty susp undef
zi-widget() {
  zle -I
  zi
  zle reset-prompt
}
zle -N zi-widget
bindkey '^z' zi-widget

# function yazi() {
# 	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
# 	command yazi "$@" --cwd-file="$tmp"
# 	IFS= read -r -d '' cwd < "$tmp"
# 	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
# 	command rm -f -- "$tmp"
# }
bindkey -s '^y' 'yazi\n'

bindkey jj vi-cmd-mode
bindkey jk vi-cmd-mode
bindkey '^e' autosuggest-accept
# bindkey '' autosuggest-execute

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

alias brewall='brew update ; brew upgrade ; brew upgrade --cask ; brew cleanup --prune=all -s ; brew autoremove ; sketchybar --trigger system_woke ; mas outdated ; mas update ; brew doctor'
alias brewfile='brew bundle dump --file="$HOME/.dotfiles/Brewfile" --force --describe'
alias v='nvim'
alias vz='nvim $HOME/.zshrc'
alias sz='source $HOME/.zshrc'
alias cl='clear'

alias l='eza --icons -l'
alias la='eza --icons -la'
alias lai='eza --icons -lai'
alias lt='eza --tree --icons -l'
alias lta='eza --tree --icons -la'
alias ltai='eza --tree --icons -lai'

alias lgit='lazygit'
alias ldocker="lazydocker"
alias ghd='gh dash'
alias oc='opencode'
