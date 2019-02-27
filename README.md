# Dotfiles


### Clone repo to `~/.dotfiles` holder:


```console
$ cd ~
$ git clone https://github.com/snuzinator/.dotfiles.git ~/.dotfiles
```

### Git
``` console
$ ln -s ~/.dotfiles/git/gitconfig ~/.gitconfig
$ ln -s ~/.dotfiles/git/gitignore_global ~/.gitignore_global
$ ln -s ~/.dotfiles/git/git_template ~/.git_template
```

### Tmux

Link to config file

```console
$ ln -s ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf
```

Install [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm)

```console
$ git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Install requirenments to system clipboard (tmux-yank plugin) for MacOS

```console
$ brew install reattach-to-user-namespace
```

Open Tmux sessions and press `Ctrl+I` for install plugins

### i3

```console
$ ln -s ~/.dotfiles/i3/ ~/.config/
```

### i3 notebook
```console
$ ln -s ~/.dotfiles/i3_notebook/ ~/.config/i3
```

### vim

```console
$ ln -s ~/.dotfiles/vim ~/.vim
$ ln -s ~/.dotfiles/vim/vimrc ~/.vimrc
$ ln -s ~/.dotfiles/vim/gvimrc ~/.gvimrc
```

### nvim

  
```console
$ ln -s ~/.dotfiles/vim/nvim  ~/.config/nvim
```
### termite

```console
$ ln -s ~/.dotfiles/termite ~/.config/termite
```
