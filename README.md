# ZSH
ZSH config, for alias and for export the correct folder
Also init de p10 powerlevel theme and colorls from ruby colorls and chromium or brave executable.

- Install ruby, bat, git (depends to your distro)
- Plugins installation:
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
- Install colorls
```bash
gem install colorls --user-install
```
- Finally:
```bash
cd ~
git clone git@github.com:CarlosMolinesPastor/zsh.git
``` 
