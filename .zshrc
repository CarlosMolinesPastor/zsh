## SOME OF THE POPULAR COMMANDS TO MAKE THIS SCRIPT
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

#######################################################################
# 🐚 ZSH CONFIGURACIÓN – Carlos Molines Pastor
#######################################################################

#!/usr/bin/env zsh

# ────[ Verificación de modo de ejecución ]───────────────────────────
if [[ -o interactive ]]; then
    # Código solo para sesiones interactivas
else
    return  # No hacer nada en sesiones no interactivas
fi

# ────[ Carga de dependencias ]───────────────────────────────────────
autoload -Uz colors && colors
autoload -Uz compinit && compinit -u
zmodload zsh/zprof  # Para profiling (opcional)

# ────[ Variables de Entorno ]────────────────────────────────────────
export ZSH="${HOME}/.oh-my-zsh"
export ZSH_CACHE_DIR="${HOME}/.cache/zsh"
export HISTFILE="${HOME}/.zsh_history"
export LESSHISTFILE="-"
export MCFLY_HISTORY="${HOME}/.mcfly_history"
export NVM_DIR="${HOME}/.nvm"
export STARSHIP_CONFIG="${HOME}/.config/starship.toml"

# Configuración de editor preferido
(( ${+commands[nvim]} )) && {
    export EDITOR="nvim"
    export VISUAL="nvim"
} || {
    export EDITOR="vim"
    export VISUAL="vim"
}

# Detección automática de Java
if (( ${+commands[java]} )); then
    export JAVA_HOME=$(dirname $(dirname $(readlink -f $(which java))))
elif (( ${+commands[archlinux-java]} )); then
    export JAVA_HOME=$(archlinux-java get)
fi

# PATH personalizado
typeset -U PATH path  # Elimina duplicados
path=(
    "${HOME}/.local/bin"
    "${HOME}/.cargo/bin"
    "${HOME}/go/bin"
    "${HOME}/.dotnet/tools"
    "/opt/Qt/Tools/QtCreator/bin"
    "/opt/Qt/Tools/QtDesignStudio/bin"
    "/usr/local/sbin"
    "/usr/local/bin"
    "/usr/sbin"
    "/usr/bin"
    "/sbin"
    "/bin"
    ${path}
)
export PATH

# ────[ Configuración de Historial ]──────────────────────────────────
HISTSIZE=10000
SAVEHIST=10000
setopt extended_history       # Registro de timestamp
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history

# ────[ Configuración de Oh-My-ZSH ]──────────────────────────────────
DISABLE_AUTO_UPDATE="true"   # Desactiva actualizaciones automáticas
ZSH_THEME=""                # Desactiva tema para usar Starship

# Plugins base
plugins=(
    git
    sudo
    systemd
)

# Plugins condicionales
[[ -d ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting ]] && plugins+=(zsh-syntax-highlighting)
[[ -d ${ZSH_CUSTOM}/plugins/zsh-autosuggestions ]] && plugins+=(zsh-autosuggestions)
[[ -d ${ZSH_CUSTOM}/plugins/fzf-tab ]] && plugins+=(fzf-tab)
[[ -f ${HOME}/.fzf.zsh ]] && source ${HOME}/.fzf.zsh

# Carga de Oh-My-ZSH
source ${ZSH}/oh-my-zsh.sh

# Carga de plugin fzf-tab
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ────[ Carga de herramientas externas ]───────────────────────────────
# NVM (Node Version Manager)
[[ -s "${NVM_DIR}/nvm.sh" ]] && source "${NVM_DIR}/nvm.sh" --no-use

# Starship Prompt
(( ${+commands[starship]} )) && eval "$(starship init zsh)"

# FZF
(( ${+commands[fzf]} )) && {
    export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --preview 'bat --color=always --style=numbers --line-range=:500 {}'"
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
}

# ────[ Configuración de Completado ]─────────────────────────────────
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'lsd --color=always $realpath'

# ────[ Alias y Funciones ]───────────────────────────────────────────
# Comprobación de comandos antes de crear alias
() {
    # Sistema de archivos
    (( ${+commands[lsd]} )) && {
        alias ls='lsd --group-dirs first'
        alias ll='lsd -lh'
        alias la='lsd -lah'
        alias lt='lsd --tree --depth 2'
    } || {
        alias ls='ls --color=auto --group-directories-first'
        alias ll='ls -lh'
        alias la='ls -lah'
    }

    # Editores
    (( ${+commands[nvim]} )) && {
        alias v='nvim'
        alias vi='nvim'
        alias vim='nvim'
    }

    # Git
    (( ${+commands[git]} )) && {
        alias gcl='git clone --depth 1'
        alias gs='git status'
        alias ga='git add'
        alias gc='git commit -m'
        alias gp='git push'
        alias gd='git diff'
    }

    # FZF
      alias fiu="fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'"
      alias vf='nvim $(fiu)'
      alias bf='bat $(fzf)'

    # Herramientas modernas
    (( ${+commands[bat]} )) && alias cat='bat'
    (( ${+commands[ranger]} )) && alias r='ranger'
    (( ${+commands[fastfetch]} )) && alias ff='fastfetch'

    # Alias de sistema
    alias vz="${EDITOR} ${HOME}/.zshrc"
    alias sz="source ${HOME}/.zshrc"
    alias c='clear'
}

# Funciones personalizadas
function mkcd() { mkdir -p "$1" && cd "$1"; }
function gacp() { git add . && git commit -m "$1" && git push; }

# ────[ Configuración de SSH ]────────────────────────────────────────
if (( ${+commands[ssh-agent]} )); then
    if ! pgrep -u "${USER}" ssh-agent > /dev/null; then
        eval "$(ssh-agent -s)" > "${HOME}/.ssh-agent.env"
    fi
    [[ -f "${HOME}/.ssh-agent.env" ]] && source "${HOME}/.ssh-agent.env"
fi

# ────[ Configuración de teclas ]─────────────────────────────────────
bindkey -e  # Modo Emacs
bindkey '^f' fzf-file-widget       # Ctrl+F para buscar archivo
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^R' history-incremental-search-backward

# ────[ Mensaje de bienvenida ]───────────────────────────────────────
if (( ${+commands[fastfetch]} )); then
    fastfetch
else
    echo -e "${fg[green]}ZSH configurado correctamente!${reset_color}"
fi
