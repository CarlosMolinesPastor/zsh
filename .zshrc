## Git
# sudo apt install git
# sudo pacman -S git
## Neovim the last version
# curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
# sudo rm -rf /opt/nvim
# sudo tar -C /opt -xzf nvim-linux64.tar.gz
# export PATH="$PATH:/opt/nvim-linux64/bin" Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
## Instalacion de zsh
# sudo apt install zsh
# sudo pacman -S zsh
# chsh -s $(which zsh)
# sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
# git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab
# mkdir ~/.oh-my-zsh/custom/plugins/antigen/
# cd ~/.oh-my-zsh/custom/plugins/antigen/
# curl -L git.io/antigen > antigen.zsh
# cd ~
## Colorls
# gem install colorls --user-install
## Bat
# sudo apt install bat
# sudo pacman -S bat
## Fzf
# sudo apt install fzf
# sudo pacman -S fzf
## Instalacion source
# cd ~
# git clone git@github.com:CarlosMolinesPastor/zsh.git
# cp ~/zsh/.zshrc ~/.zshrc
# Starsip
# curl -sS https://starship.rs/install.sh | sh

#if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
# source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
#fi

# $PATH.
export PATH="$HOME/bin:/usr/local/bin:$HOME/.local/bin:$HOME/.local/share/gem/ruby/3.3.0/bin:$HOME/.cargo/bin:$HOME/go/bin:$GOPATH/bin:$HOME/.dotnet/tools:/opt/Qt:/opt/Qt/Tools/QtCreator/bin:/opt/Qt/Tools/QtDesignStudio/bin:/usr/local/sbin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:$PATH"
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk


# CHROME for FLutter
export CHROME_EXECUTABLE="/usr/bin/chromium"

# Oh my zsh
export ZSH="$HOME/.oh-my-zsh"
plugins=(git zsh-syntax-highlighting zsh-autosuggestions fzf-tab nvm)
source $ZSH/oh-my-zsh.sh

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

#Antigen
#source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/antigen/antigen.zsh

## fzf
#source <(fzf --zsh)

#colorls
source $(dirname $(gem which colorls))/tab_complete.sh

##Alias
# omz
alias vz="nvim ~/.zshrc"
# ls
alias l='colorls -lh'
alias ll='colorls -lah'
alias la='colorls -lA --sd'
alias ls='colorls'
alias lg='colorls -l --group-directories-first'

## lsd vs colorls
#alias l='ls -l'
#alias la='ls -a'
#alias lla='ls -la'
#alias lt='ls --tree'

# git
alias gcl='git clone --depth 1'
alias gi='git init'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push origin master'

# cat
alias cat='bat'
alias b='bat'
export BAT_THEME="Catppuccin Mocha"

## Ubuntu
#alias cat='batcat'
#alias b='batcat'

# vim
alias v='nvim'
alias vi='nvim'
alias vim='nvim'

# clear
alias c='clear'

# fzf
# Buscar archivo y muestra una previsualización con bat en la derecha
alias fiu="fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'"
alias vf='nvim $(fiu)'
alias bf='bat $(fzf)'

alias ff='fastfetch'

alias r='ranger'

bindkey -e
bindkey '^f' fzf-file-widget 
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# History
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_ignore_space

# Zstyle
zstyle ':completion:*' menu no
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors ''
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'lsd --color $realpath'


## Init ssh server
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > ~/.ssh-agent.env
fi
if [[ ! "$SSH_AUTH_SOCK" ]]; then
    eval "$(<~/.ssh-agent.env)"
fi
# ssh-add ~/.ssh/id_ecdsa
clear
eval "$(starship init zsh)"
