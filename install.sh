#!/usr/bin/env bash

# Init option {{{
Color_off='\033[0m'       # Text Reset

# terminal color template {{{
# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White

# Underline
UBlack='\033[4;30m'       # Black
URed='\033[4;31m'         # Red
UGreen='\033[4;32m'       # Green
UYellow='\033[4;33m'      # Yellow
UBlue='\033[4;34m'        # Blue
UPurple='\033[4;35m'      # Purple
UCyan='\033[4;36m'        # Cyan
UWhite='\033[4;37m'       # White

# Background
On_Black='\033[40m'       # Black
On_Red='\033[41m'         # Red
On_Green='\033[42m'       # Green
On_Yellow='\033[43m'      # Yellow
On_Blue='\033[44m'        # Blue
On_Purple='\033[45m'      # Purple
On_Cyan='\033[46m'        # Cyan
On_White='\033[47m'       # White

# High Intensity
IBlack='\033[0;90m'       # Black
IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
IBlue='\033[0;94m'        # Blue
IPurple='\033[0;95m'      # Purple
ICyan='\033[0;96m'        # Cyan
IWhite='\033[0;97m'       # White

# Bold High Intensity
BIBlack='\033[1;90m'      # Black
BIRed='\033[1;91m'        # Red
BIGreen='\033[1;92m'      # Green
BIYellow='\033[1;93m'     # Yellow
BIBlue='\033[1;94m'       # Blue
BIPurple='\033[1;95m'     # Purple
BICyan='\033[1;96m'       # Cyan
BIWhite='\033[1;97m'      # White

# High Intensity backgrounds
On_IBlack='\033[0;100m'   # Black
On_IRed='\033[0;101m'     # Red
On_IGreen='\033[0;102m'   # Green
On_IYellow='\033[0;103m'  # Yellow
On_IBlue='\033[0;104m'    # Blue
On_IPurple='\033[0;105m'  # Purple
On_ICyan='\033[0;106m'    # Cyan
On_IWhite='\033[0;107m'   # White
# }}}

# version
Version='1.0.0-dev'
#System name
System="$(uname -s)"

# }}}

# fetch_repo {{{
fetch_repo () {
  if [[ -d "$HOME/.dotfiles" ]]; then
    info "Trying to update dotfiles"
    cd "$HOME/.dotfiles"
    git pull https://github.com/snuzinator/.dotfiles.git master
    cd - > /dev/null 2>&1
    success "Successfully update dotfiles"
  else
    info "Trying to clone dotfiles from snuz"
    git clone https://github.com/snuzinator/.dotfiles.git "$HOME/.dotfiles"
    success "Successfully clone dotfiles"
  fi
}

# }}}

# usage {{{
usage (){
  echo "add key: (example ./bash --pc)"
  echo ""
  echo "OPTIONS"
  echo ""
  echo "--pc                          install for Desktop"
  echo "--notebook                    install for Notebook"
}
# }}}

# success/msg {{{
msg() {
  printf '%b\n' "$1" >&2
}

success() {
  msg "${Green}[✔]${Color_off}  ${1}${2}"
}

info() {
  msg "${Blue}[➭]${Color_off} ${1}${2}"
}
# }}}

# echo_with_color {{{
echo_with_color () {
  printf '%b\n' "$1$2$Color_off" >&2
}
# }}}

# install_done {{{

install_done () {
  echo_with_color ${Yellow} ""
  echo_with_color ${Yellow} "Almost done!"
  echo_with_color ${Yellow} "=============================================================================="
  echo_with_color ${Yellow} "==    Open Vim or Neovim and it will install the plugins automatically      =="
  echo_with_color ${Yellow} "=============================================================================="
  echo_with_color ${Yellow} ""
  echo_with_color ${Yellow} "That's it. Thanks for installing Dotfiles Snuz. Enjoy!"
  echo_with_color ${Yellow} ""
}

# }}}

# install_vim {{{
install_vim (){
  if [[ -f "$HOME/.vimrc" ]]; then
    mv "$HOME/.vimrc" "$HOME/.vimrc_back"
    success "Backup $HOME/.vimrc to $HOME/.vimrc_back"
    ln -s "$HOME/.dotfiles/vim/vimrc" "$HOME/.vimrc" 
  fi
  if [[ -d "$HOME/.vim" ]]; then
    if [[ "$(readlink $HOME/.vim)" =~ dotfiles ]]; then
      success "Link $HOME/.vim Already installed for vim"
    else
      mv "$HOME/.vim" "$HOME/.vim_back"
      success "BackUp $HOME/.vim to $HOME/.vim_back"
      ln -s "$HOME/.dotfiles/vim" "$HOME/.vim"
      success "Installed dotfiles for vim"
    fi
  else
    ln -s "$HOME/.dotfiles/vim" "$HOME/.vim"
    ln -s "$HOME/.dotfiles/vim/vimrc" "$HOME/.vimrc" 
    success "Installed dotfile for vim"
  fi
}
# }}}

# uninstall_vim {{{
uninstall_vim () {
  if [[ -d "$HOME/.vim" ]]; then
    if [[ "$(readlink $HOME/.vim)" =~ .dotfiles ]]; then
      rm "$HOME/.vim"
      success "Uninstall dotfile folder vim"
      if [[ -d "$HOME/.vim_back" ]]; then
        mv "$HOME/.vim_back" "$HOME/.vim"
        success "Recover from $HOME/.vim_back"
      fi
    fi
  fi
  if [[ -f "$HOME/.vimrc_back" ]]; then
    mv "$HOME/.vimrc_back" "$HOME/.vimrc"
    success "Recover from $HOME/.vimrc_back"
  fi
}
# }}}

# install_git {{{
install_git () {
  if [[ -f "$HOME/.gitconfig" ]]; then
    mv "$HOME/.gitconfig" "$HOME/.gitconfig_back"
    success "Backup $HOME/.gitconfig to $HOME/.gitconfig_back"
    ln -s "$HOME/.dotfiles/git/gitconfig" "$HOME/.gitconfig"
  else
    ln -s "$HOME/.dotfiles/git/gitconfig" "$HOME/.gitconfig"
    success "Installed dotfile for gitconfig"
  fi
  if [[ -f "$HOME/.gitignore_global" ]]; then
    mv "$HOME/.gitignore_global" "$HOME/.gitignore_global_back"
    success "Backup $HOME/.gitignore_global to $HOME/.gitignore_global_back"
    ln -s "$HOME/.dotfiles/git/gitignore_global" "$HOME/.gitignore_global"
  else
    ln -s "$HOME/.dotfiles/git/gitignore_global" "$HOME/.gitignore_global"
    success "Installed dotfile for gitignore_global"
  fi
  if [[ -d "$HOME/.git_template" ]]; then
    if [[ "$(readlink $HOME/.git_template)" =~ dotfiles ]]; then
      success "Link $HOME/.git_template Already installed for git"
    else
      mv "$HOME/.git_template" "$HOME/.git_template_back"
      success "Backup $HOME/.git_template to $HOME/.git_template_back"
      ln -s "$HOME/.dotfiles/git/git_template" "$HOME/.git_template"
    fi
  else
    ln -s "$HOME/.dotfiles/git/git_template" "$HOME/.git_template"
    success "Installed dotfile for git_template"
  fi
}
#}}}

# uninstall_git {{{
uninstall_git (){
  if [[ -d "$HOME/.git_template" ]]; then
    if [[ "$(readlink $HOME/.git_template)" =~ dotfiles ]]; then
      rm "$HOME/.git_template"
      success "Uninstall dotfile git_template"
      if [[ -d "$HOME/.git_template_back" ]]; then
        mv "$HOME/.git_template_back" "$HOME/.git_template"
        success "Recover from $HOME/.git_template_back"
      fi
    fi
  fi
  if [[ -f "$HOME/.gitconfig_back" ]]; then
    mv "$HOME/.gitconfig_back" "$HOME/.gitconfig"
    success "Recover from $HOME/.gitconfig_back"
  fi
  if [[ -f "$HOME/.gitignore_global_back" ]]; then
    mv "$HOME/.gitignore_global_back" "$HOME/.gitignore_global"
    success "Recover from $HOME/.gitignore_global_back"
  fi
}
#}}}

# install_tmux {{{
install_tmux (){
  if [[ -f "$HOME/.tmux.conf" ]]; then
    mv "$HOME/.tmux.conf" "$HOME/.tmux.conf_back"
    success "Buckup $HOME/.tmux.conf to $HOME/.tmux.conf_back"
    ln -s "$HOME/.dotfiles/tmux/tmux.conf" "$HOME/.tmux.conf"
  else
    ln -s "$HOME/.dotfiles/tmux/tmux.conf" "$HOME/.tmux.conf"
    success "Installed dotfile for tmux.conf"
  fi
  if [[ -d "$HOME/.tmux" ]]; then
    if [[ "$(readlink $HOME/.tmux)" =~ dotfiles ]]; then
      success "Link $HOME/.tmux Already installed for tmux"
    else
      mv "$HOME/.tmux" "$HOME/.tmux_back"
      success "Backup $HOME/.tmux to $HOME/.tmux_back"
      ln -s "$HOME/.dotfiles/tmux" "$HOME/.tmux"
    fi
  else
    ln -s "$HOME/.dotfiles/tmux" "$HOME/.tmux"
    success "Installed folder for tmux"
  fi
  if [[ -d "$HOME/.tmux/plugins/tpm" ]]; then
    if [[ -f "$HOME/.tmux/plugins/tpm/tpm" ]]; then
      info "Trying to update tpm"
      cd "$HOME/.tmux/plugins/tpm"
      git pull
      cd - > /dev/null 2>&1
      success "Successfully update tpm"
    fi
  else
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
    success "Tmux Plugin Manager"
    info "Open Tmux sessions and press `Ctrl+I` for install plugins"
  fi
}

#}}}

if [[ $1 = "" || $1 = "--help" ]]; then
  usage
fi

if [[ $1 == "--pc" ]]; then
  echo "install PC"
  echo ""
  fetch_repo
  install_vim
  install_git
  install_tmux
  install_done
elif [[ $1 == "--notebook" ]]; then
  echo "install Notebook"
  echo ""
  fetch_repo
  install_vim
  install_git
  install_tmux
  install_done
elif [[ $1 == "--uninstall" ]]; then
  echo ""
  echo "uninstalling..."
  uninstall_vim
  uninstall_git
else
  usage
fi
