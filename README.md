# ZSH
Zsh is a terminal prompt used for take more advatages on terminal.
First you have to install in your distro gnu/linux, like
```bash
sudo apt install zsh
sudo pacman -S zsh
```
Then make the shell primary with
```bash
sudo chsh -s /usr/bin/zsh
```
Exit of the session and init now.
Then I give my config to you.
ZSH config, for alias and for export the correct folder
Also init de p10 powerlevel theme and colorls from ruby colorls and chromium or brave executable.

- **Install ruby and ruby-dev, bat, (in ubuntu the command is batcat), git (depends to your distro)**
- **Plugins installation**:
```bash
sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
mkdir ~/.oh-my-zsh/custom/plugins/antigen/
cd ~/.oh-my-zsh/custom/plugins/antigen/
curl -L git.io/antigen > antigen.zsh
cd ~
```

- **Install colorls**
```bash
gem install colorls --user-install
```
- Or else you can install lsd in your distribution ej:
```bash
sudo apt install lsd
```
and then comment the lines of colorls and uncomment the lines of lsd

- **Finally**:
```bash
cd ~
git clone git@github.com:CarlosMolinesPastor/zsh.git
``` 
