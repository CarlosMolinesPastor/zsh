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

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
 source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export ZSH="$HOME/.oh-my-zsh"
export PATH=$HOME/.local/share/gem/ruby/3.2.0/bin:$PATH
export PATH=$PATH:$HOME.local/bin:$HOME/bin:/usr/local/bin:/usr/local/sbin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:$HOME/.dotnet/tools:/opt/Qt:/opt/Qt/Tools/QtCreator/bin:/opt/Qt/Tools/QtDesignStudio/bin:$HOME/.cargo/env:$HOME/.cargo/bin
export PATH="$HOME/go/bin:$GOPATH/bin:$PATH"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
source $(dirname $(gem which colorls))/tab_complete.sh

# CHROME for FLutter
# export CHROME_EXECUTABLE="/opt/brave-bin/brave"
export CHROME_EXECUTABLE="/usr/bin/chromium"

#Plugins
plugins=(git zsh-syntax-highlighting zsh-autosuggestions fzf-tab)
source $ZSH/oh-my-zsh.sh

#Antigen
source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/antigen/antigen.zsh

## fzf
source <(fzf --zsh)

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

# Zstyle
zstyle ':completion:*' menu no
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors ''
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'


## Init ssh server
eval "$(ssh-agent -s)"
# ssh-add ~/.ssh/id_ecdsa
clear
prompt off
eval "$(starship init zsh)"
