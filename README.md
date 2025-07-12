# Bredes dotfiles

This repository stores dotfiles (e.g. ".zshrc") so I can easily fetch my
prefered configs for the tools I use.  

Use GNU Stow to create symlinks.

Install GNU Stow

```console
sudo pacman -S stow
```

Create symlinks

```console
stow <name>
```

Remove symlinks

```console
stow -D <name>
```

## Installation

### Alacritty

Download [JetBrainsMono Nerd Font](https://www.nerdfonts.com/font-downloads)  

Install and refresh fonts

```console
sudo mkdir /usr/local/share/fonts
sudo unzip $HOME/Downloads/JetBrainsMono.zip -d /usr/local/share/fonts/JetBrainsMono
fc-cache -f
```

Symlink

```console
stow alacritty
```

### zsh

First install zsh and oh-my-zsh

```console
sudo pacman -S zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Install dependencies (zsh-autosuggestions, zsh-syntax-highlighting, pure promt)

```console
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
mkdir -p "$HOME/.zsh" && git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"
```

Install zoxide for better cd

```console
sudo pacman -S zoxide
```

Replace .zshrc file

```console
rm $HOME/.zshrc
stow zsh
```

### tmux

Install tmux plugin manager

```console
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Symlink

```console
stow tmux
```

Inside tmux run \<C-a\> + \<C-I\> to initialize tpm

### nvim

Install neovim and dependancies

```console
sudo pacman -S neovim fzf ripgrep lazygit fd
```

Symlink

```console
stow nvim
```

### git

[Set up SSH](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)

Symlink

```console
stow git
```
