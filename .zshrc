# ----[ SOME OF THE POPULAR COMMANDS TO MAKE THIS SCRIPT ]------------
## GIT
# sudo apt install git
# sudo pacman -S git
## NEOVIM manual instalation
# curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
# sudo rm -rf /opt/nvim
# sudo tar -C /opt -xzf nvim-linux64.tar.gz
# export PATH="$PATH:/opt/nvim-linux64/bin"
## ZSH
# sudo apt install zsh
# sudo pacman -S zsh
# chsh -s $(which zsh)
# --------------------------------------------------------------------

#!/usr/bin/env zsh

# ────[ Solo modo interactivo ]───────────────────────────────────────
[[ -o interactive ]] || return

# ────[ Autoload y colores ]──────────────────────────────────────────
autoload -Uz colors && colors
autoload -Uz compinit

# ────[ Inicialización de Completado ]────────────────────────────────
setopt extended_glob

cache_dir="${HOME}/.cache/zsh"
[[ -d "$cache_dir" ]] || mkdir -p "$cache_dir"

zcomp="${cache_dir}/.zcompdump"

if [[ -f "$zcomp" && "$zcomp" -nt "${ZDOTDIR:-$HOME}/.zshrc" ]]; then
    compinit -d "$zcomp"
    zcompile -U "$zcomp" 2>/dev/null
else
    compinit -C -d "$zcomp"
fi

# ────[ Variables de Entorno ]────────────────────────────────────────
export ZSH="${HOME}/.oh-my-zsh"
export ZSH_CACHE_DIR="${HOME}/.cache/zsh"
export HISTFILE="${HOME}/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000

# ────[ PATH ]────────────────────────────────────────────────────────
typeset -U PATH path
path=(
    "${HOME}/.local/bin"
    "${HOME}/.cargo/bin"
    "${HOME}/go/bin"
    "/usr/local/bin"
    "/usr/bin"
    $path
)
export PATH

# ────[ Oh-My-Zsh y Plugins Principales ]─────────────────────────────
plugins=(git sudo systemd)
source "${ZSH}/oh-my-zsh.sh"

# ────[ Plugins Críticos Posteriores ]────────────────────────────────
for plugin in \
    "${ZSH_CUSTOM}/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" \
    "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
do
    [[ -f "$plugin" ]] && source "$plugin"
done

export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
export ZSH_AUTOSUGGEST_USE_ASYNC=1

# ────[ Plugins Adicionales ]─────────────────────────────────────────
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh
[[ -f "${ZSH_CUSTOM}/plugins/fzf-tab/fzf-tab.plugin.zsh" ]] &&
    source "${ZSH_CUSTOM}/plugins/fzf-tab/fzf-tab.plugin.zsh"

# ────[ Configuración de Completado ]─────────────────────────────────
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# ────[ Aliases ]─────────────────────────────────────────────────────
if (( ${+commands[lsd]} )); then
    alias ls='lsd --group-dirs first'
    alias ll='lsd -lh'
    alias la='lsd -lah'
    alias lt='lsd --tree --depth 2'
else
    alias ls='ls --color=auto --group-directories-first'
    alias ll='ls -lh'
    alias la='ls -lah'
fi

(( ${+commands[nvim]} )) && alias vim='nvim'

if (( ${+commands[git]} )); then
    alias gs='git status'
    alias ga='git add'
    alias gc='git commit'
    alias gp='git push'
fi

(( ${+commands[bat]} )) && alias cat='bat'
(( ${+commands[ranger]} )) && alias r='ranger'

# ────[ Funciones Personalizadas ]────────────────────────────────────
mkcd() { mkdir -p "$1" && cd "$1"; }
gacp() { git add . && git commit -m "$1" && git push; }

# ────[ Herramientas Externas ]───────────────────────────────────────
[[ -s "${NVM_DIR}/nvm.sh" ]] && {
    export NVM_LAZY_LOAD=true
    source "${NVM_DIR}/nvm.sh" --no-use
}

# ────[ Configuración de Teclas ]─────────────────────────────────────
bindkey -e
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^R' history-incremental-search-backward

# ────[ Prompt (Starship) ]───────────────────────────────────────────
(( ${+commands[starship]} )) && eval "$(starship init zsh)"


echo -e "${BLUE}"
echo " ██╗  ██╗ █████╗ ██████╗ ██╗     ██╗███╗   ██╗██╗   ██╗██╗  ██╗"
echo " ██║ ██╔╝██╔══██╗██╔══██╗██║     ██║████╗  ██║██║   ██║╚██╗██╔╝"
echo " █████╔╝ ███████║██████╔╝██║     ██║██╔██╗ ██║██║   ██║ ╚███╔╝ "
echo " ██╔═██╗ ██╔══██║██╔══██╗██║     ██║██║╚██╗██║██║   ██║ ██╔██╗ "
echo " ██║  ██╗██║  ██║██║  ██║███████╗██║██║ ╚████║╚██████╔╝██╔╝ ██╗"
echo " ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚═╝  ╚═╝"
echo -e "${NC}"

