# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export ZSH="$HOME/.oh-my-zsh"
export PATH=$PATH:$HOME/.dotnet/tools
export PATH=/home/carlos/.local/share/gem/ruby/3.0.0/bin:$PATH
export PATH=$PATH:$HOME.local/bin:/home/carlos/bin:/usr/local/bin:/usr/local/sbin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/carlos/.dotnet/tools:/opt/Qt:/opt/Qt/Tools/QtCreator/bin:/opt/Qt/Tools/QtDesignStudio/bin:$HOME/.cargo/env:$HOME/.cargo/bin
# Neovim
# curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
# sudo rm -rf /opt/nvim
# sudo tar -C /opt -xzf nvim-linux64.tar.gz
# export PATH="$PATH:/opt/nvim-linux64/bin"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
source $(dirname $(gem which colorls))/tab_complete.sh
export PATH=$PATH:$HOME/.local/share/gem/ruby/3.0.0/bin
# CHROME for FLutter
# export CHROME_EXECUTABLE="/opt/brave-bin/brave"
export CHROME_EXECUTABLE="/usr/bin/chromium"

#Plugins
plugins=(git zsh-syntax-highlighting zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

#Antigen
source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/antigen/antigen.zsh

# Theme
source ~/.oh-my-zsh/custom/themes/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

##Alias
# omz
alias zshconfig="nvim ~/.zshrc"
# ls
alias l='colorls -lh'
alias ll='colorls -lah'
alias la='colorls -lA --sd'
alias ls='colorls'
alias lg='colorls -l --group-directories-first'
# git
alias gcl='git clone --depth 1'
alias gi='git init'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push origin master'
# cat
alias cat='bat'
alias b='bat'
# vim
alias vi='nvim'
alias vim='nvim'
# clear
alias c='clear'

alias ff='fastfetch'

## Init ssh server
eval "$(ssh-agent -s)"
# ssh-add ~/.ssh/id_ecdsa
## Errors pk10
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
clear
