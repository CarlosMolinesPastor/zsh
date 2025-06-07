#######################################################################
## SOME OF THE POPULAR COMMANDS TO MAKE THIS SCRIPT
## GIT
# sudo apt install git
# sudo pacman -S git
## NEOVIM
# curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
# sudo rm -rf /opt/nvim
# sudo tar -C /opt -xzf nvim-linux64.tar.gz
# export PATH="$PATH:/opt/nvim-linux64/bin"
## ZSH
# sudo apt install zsh
# sudo pacman -S zsh
# chsh -s $(which zsh)
# sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
# git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab
# cd ~
## BAT
# sudo apt install bat
# sudo pacman -S bat
## FZF
# sudo apt install fzf
# sudo pacman -S fzf
## INSTALACION PROPIA
# cd ~
# git clone git@github.com:CarlosMolinesPastor/zsh.git
# cp ~/zsh/.zshrc ~/.zshrc
## STARSHIP
# curl -sS https://starship.rs/install.sh | sh
#######################################################################

#######################################################################
# 🐚 ZSH CONFIGURACIÓN OPTIMIZADA – Carlos Molines Pastor
#######################################################################

## ─── VARIABLES DE ENTORNO ───────────────────────────────────────────
export ZSH="$HOME/.oh-my-zsh"
export CHROME_EXECUTABLE="/usr/bin/chromium"
export NVM_DIR="$HOME/.nvm"
# Detectar automáticamente JAVA_HOME
if type -p java &>/dev/null; then
  JAVA_BIN=$(readlink -f "$(which java)")
  JAVA_HOME=$(dirname "$(dirname "$JAVA_BIN")")
  export JAVA_HOME
else
  echo "⚠️  Java no está instalado o no está en el PATH"
fi

# Añadir rutas al PATH
export PATH="$HOME/bin:$HOME/.local/bin:$HOME/.cargo/bin:$HOME/go/bin:$GOPATH/bin:$HOME/.dotnet/tools:/opt/Qt:/opt/Qt/Tools/QtCreator/bin:/opt/Qt/Tools/QtDesignStudio/bin:/usr/local/sbin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin:$PATH"

## ─── HISTORIAL ──────────────────────────────────────────────────────
HISTFILE="$HOME/.zsh_history"
HISTSIZE=5000
SAVEHIST=5000
setopt appendhistory sharehistory hist_ignore_space hist_ignore_all_dups

## ─── PLUGINS DE OH-MY-ZSH ───────────────────────────────────────────
plugins=(git)

[[ -d ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting ]] && plugins+=("zsh-syntax-highlighting")
[[ -d ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions ]] && plugins+=("zsh-autosuggestions")
[[ -d ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fzf-tab ]] && plugins+=("fzf-tab")
[[ -d "$NVM_DIR" ]] && plugins+=("nvm")
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source $ZSH/oh-my-zsh.sh

## ─── NVM ────────────────────────────────────────────────────────────
[[ -s "$NVM_DIR/nvm.sh" ]] && \. "$NVM_DIR/nvm.sh"

## ─── STARSHIP PROMPT ────────────────────────────────────────────────
command -v starship &>/dev/null && eval "$(starship init zsh)"

## ─── COLORLS COMPLETION ─────────────────────────────────────────────
if command -v colorls &>/dev/null; then
  source "$(dirname "$(gem which colorls)")/tab_complete.sh"
fi

## ─── FZF PREVIEW PARA CD ────────────────────────────────────────────
command -v lsd &>/dev/null && zstyle ':fzf-tab:complete:cd:*' fzf-preview 'lsd --color $realpath'

## ─── SSH AGENT ──────────────────────────────────────────────────────
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
  eval "$(ssh-agent -s)" > ~/.ssh-agent.env
fi
[[ -f ~/.ssh-agent.env ]] && source ~/.ssh-agent.env
# ssh-add ~/.ssh/id_ecdsa  # Descomentar si usas clave privada fija

## ─── ALIAS ÚTILES ───────────────────────────────────────────────────

# Zsh config
alias vz="nvim ~/.zshrc"
alias sz="source ~/.zshrc"

# === Alias para lsd (recomendado) ===
if command -v lsd &>/dev/null; then
  alias ls='lsd'
  alias l='lsd -lh'
  alias ll='lsd -lah'
  alias la='lsd -la'
  alias lt='lsd --tree'
  alias lg='lsd -l --group-dirs=first'
else
  echo "⚠️  lsd no está instalado, instala con: sudo pacman -S lsd"
fi

# Alias para fzf con bat (previsualización)
if command -v fzf &>/dev/null && command -v bat &>/dev/null; then
  alias fiu="fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'"
  alias vf='nvim $(fiu)'
  alias bf='bat $(fzf)'
fi

# Git
alias gcl='git clone --depth 1'
alias gi='git init'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias gs='git status'
alias gd='git diff'

# BAT
if command -v batcat &>/dev/null; then
  alias cat='batcat'
  alias b='batcat'
else
  alias cat='bat'
  alias b='bat'
fi

# Neovim
alias v='nvim'
alias vi='nvim'
alias vim='nvim'

# Varios
alias r='ranger'
alias c='clear'
alias ff='fastfetch'

## ─── TECLAS RÁPIDAS (bindkeys) ──────────────────────────────────────
bindkey -e                          # Estilo emacs
bindkey '^f' fzf-file-widget       # Ctrl+F para buscar archivo
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

## ─── CLEAR Y BIENVENIDA FINAL ───────────────────────────────────────
clear
