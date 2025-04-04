# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
export PATH="$HOME/.local/bin:$PATH"

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [[ -f "/opt/homebrew/bin/brew" ]]; then
  # If you're using macOS, you'll want this enabled
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit ice silent; zinit snippet OMZL::git.zsh
zinit ice silent; zinit snippet OMZP::git
zinit ice silent; zinit snippet OMZP::sudo
zinit ice silent; zinit snippet OMZP::node
zinit ice silent; zinit snippet OMZP::npm
zinit ice silent; zinit snippet OMZP::nvm
zinit ice silent; zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# History
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

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls='ls --color'
alias vim='nvim'
alias c='clear'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"



# Use only the main highlighter
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main)

# Muted / dull color styles
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main)

# Slightly brighter muted colors
ZSH_HIGHLIGHT_STYLES[comment]='fg=245'                  # Light gray
ZSH_HIGHLIGHT_STYLES[command]='fg=48'                  # Soft cyan
ZSH_HIGHLIGHT_STYLES[builtin]='fg=81'                   # Brighter teal
ZSH_HIGHLIGHT_STYLES[function]='fg=114'                 # Medium green
ZSH_HIGHLIGHT_STYLES[alias]='fg=139'                    # Dusty purple
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=179'            # Muted yellow
ZSH_HIGHLIGHT_STYLES[globbing]='fg=180'                 # Pale yellow
ZSH_HIGHLIGHT_STYLES[path]='fg=252'                     # Light gray
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=109'   # Soft green
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=186'   # Creamy yellow
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=160,bold'       # Mild red
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=240'         # Subtle separator

