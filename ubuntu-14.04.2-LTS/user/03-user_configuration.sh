#!/bin/bash

echo -e "\033[1;33m===================================\033[0m"
echo -e "\033[1;33m==========[USER SPECIFIC]==========\033[0m"
echo -e "\033[1;33m===================================\033[0m"

read -p "Enter the name of the github user to clone the dotfiles from: " github_user

## Setup VIM as default editor
sudo update-alternatives --set editor /usr/bin/vim.basic

##
## ZSH
##
echo -e "\033[1;33m=                                 =\033[0m"
echo -e "\033[1;33m=========[INSTALLING zsh]==========\033[0m"
echo -e "\033[1;33m=                                 =\033[0m"
sudo apt-get install -y zsh
sudo usermod -s /bin/zsh "$(whoami)"
##apt-fast completions for zsh
sudo cp ~/apt-fast/completions/zsh/_apt-fast /usr/share/zsh/functions/Completion/Debian/
sudo chown root:root /usr/share/zsh/functions/Completion/Debian/_apt-fast
source /usr/share/zsh/functions/Completion/Debian/_apt-fast

##Setup Prezto
echo -e "\033[1;33m=                                     =\033[0m"
echo -e "\033[1;33m==========[INSTALLING Prezto]==========\033[0m"
echo -e "\033[1;33m=                                     =\033[0m"
git clone --recursive https://github.com/ravishi/prezto.git "$HOME/.zprezto"

shopt -s extglob
for rcfile in $HOME/.zprezto/runcoms/!(README.md); do
  ln -s "$rcfile" "$HOME/.$(basename $rcfile)"
done

# powerline fancy symbols
echo -e "\033[1;33m=                                     =\033[0m"
echo -e "\033[1;33m=====[Installing Powerline symbols]====\033[0m"
echo -e "\033[1;33m=                                     =\033[0m"
mkdir -p "$HOME/.fonts/" "$HOME/.config/fontconfig/conf.d/"
wget -P "$HOME/.fonts/" https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf
sudo fc-cache -vf "$HOME/.fonts"
wget -P "$HOME/.config/fontconfig/conf.d/" https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf

## Get dotfiles
echo -e "\033[1;33m=                                     =\033[0m"
echo -e "\033[1;33m=========[Retrieving dotfiles]=========\033[0m"
echo -e "\033[1;33m=                                     =\033[0m"
# Create a tmp folder with random name
dotfiles_path="`(mktemp -d)`"
 
# Clone the repository recursively

git clone --recursive "https://github.com/${github_user}/dotfiles.git" "$dotfiles_path"
cd "$dotfiles_path"
 
# Copy all dotfiles except .git/ and .gitmodules
cp -r `ls -d .??* | egrep -v '(.git$|.gitmodules)'` $HOME
cd ~
rm -rf "$dotfiles_path"

# symlink vimrc
ln -s "$HOME/.vim/vimrc" "$HOME/.vimrc"

## TMUX
# Install Tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

tmux source-file ~/.tmux.conf

echo -e "\033[1;33m=                                     =\033[0m"
echo -e "\033[1;33m============[Installing RVM]===========\033[0m"
echo -e "\033[1;33m=                                     =\033[0m"
sudo apt-add-repository -y ppa:rael-gc/rvm
sudo apt-fast update
sudo apt-fast install rvm
echo -e "\031[1;32mYou need to logout and login again to install ruby!!\033[0m"

echo -e "\033[1;32mUser configuration complete!!\033[0m"
