#!/bin/bash

echo "==================================="
echo "==========[USER SPECIFIC]=========="
echo "==================================="

## Setup VIM as default editor
sudo update-alternatives --set editor /usr/bin/vim.basic

##
## ZSH
##
echo "=                                 ="
echo "=========[INSTALLING zsh]========="
echo "=                                 ="
sudo apt-get install -y zsh
sudo usermod -s /bin/zsh "$(whoami)"
##apt-fast completions for zsh
sudo cp ~/apt-fast/completions/zsh/_apt-fast /usr/share/zsh/functions/Completion/Debian/
sudo chown root:root /usr/share/zsh/functions/Completion/Debian/_apt-fast
source /usr/share/zsh/functions/Completion/Debian/_apt-fast

##Setup Prezto
echo "=                                     ="
echo "==========[INSTALLING Prezto]=========="
echo "=                                     ="
git clone --recursive https://github.com/ravishi/prezto.git "$HOME/.zprezto"

shopt -s extglob
for rcfile in $HOME/.zprezto/runcoms/!(README.md); do
  ln -s "$rcfile" "$HOME/.$(basename $rcfile)"
done

# powerline fancy symbols
echo "=                                     ="
echo "=====[Installing Powerline symbols]===="
echo "=                                     ="
mkdir -p "$HOME/.fonts/" "$HOME/.config/fontconfig/conf.d/"
wget -P "$HOME/.fonts/" https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf
sudo fc-cache -vf "$HOME/.fonts"
wget -P "$HOME/.config/fontconfig/conf.d/" https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf

## Get dotfiles
echo "=                                     ="
echo "=========[Retrieving dotfiles]========="
echo "=                                     ="
echo '=> Get dotfiles (http://github.com/drkarl/dotfiles)'
# Create a tmp folder with random name
dotfiles_path="`(mktemp -d)`"
 
# Clone the repository recursively
git clone --recursive https://github.com/drkarl/dotfiles.git "$dotfiles_path"
cd "$dotfiles_path"
 
# Copy all dotfiles except .git/ and .gitmodules
cp -r `ls -d .??* | egrep -v '(.git$|.gitmodules)'` $HOME

# symlink vimrc
ln -s "$HOME/.vim/vimrc" "$HOME/.vimrc"

rm -rf "$dotfiles_path"
rm -rf apt-fast
rm -rf install-scripts

echo "User configuration complete!!"
