# ZSH

Zsh is a terminal prompt used for take more advatages on terminal.
First you have to install in your distro gnu/linux, like

```bash
sudo apt install zsh fzf ripgrep lsd bat
sudo pacman -S zsh fzf ripgrep lsd bat starship
```

Then make the shell primary with

```bash
sudo chsh -s /usr/bin/zsh
```

```bash
curl -sS https://starship.rs/install.sh | sh
```

Exit of the session and init now.
Then I give my config to you.
ZSH config, for alias and for export the correct folder

- **Plugins installation**:

```bash
sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --key-bindings --completion --no-update-rc
cd ~
```

- **Finally**:

```bash
cd ~
git clone https://github.com/CarlosMolinesPastor/zsh.git
cp ~/zsh/.zshrc ~/.zshrc
```

<div style='text-align: center';>
  
![](https://github.com/CarlosMolinesPastor/zsh/blob/main/Screenshot_2024-09-19-18-09-23_1920x1080.png)

</div>
