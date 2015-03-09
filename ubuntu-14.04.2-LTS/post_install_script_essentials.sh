#!/bin/bash
##
# Ubuntu post-install script
##


##
##apt-fast
##
echo "=========[INSTALLING apt-fast]========="
sudo apt-get install -y git aria2
git clone https://github.com/ilikenwf/apt-fast.git
cd apt-fast
sudo cp apt-fast /usr/bin/
sudo chmod +x /usr/bin/apt-fast
sudo cp completions/bash/apt-fast /etc/bash_completion.d/
     
## Add Node PPA
curl -sL https://deb.nodesource.com/setup | sudo bash -

##
#Update repos and upgrade software
##
echo "=========[Update and Upgrade]========="
sudo apt-fast update -y && sudo apt-fast upgrade -y

##
##Essentials
##
echo "=========[INSTALLING essentials]========="
sudo apt-fast install -y --no-install-recommends build-essential fontconfig fonts-inconsolata unzip p7zip-full ack-grep htop tmux molly-guard etckeeper

##
##Setup git
##
echo "=========[Git setup]========="
git config --global user.name "Carlos Manias"
git config --global user.email karlmaxxx@gmail.com

##
##etc-keeper
##
echo "=========[INSTALLING etckeeper]========="
perl -pi -e 's/VCS="bzr"/VCS="git"/' /etc/etckeeper/etckeeper.conf
etckeeper init
etckeeper commit "Initial commit."

##
##Install NodeJS
##
echo "=========[INSTALLING NodeJS]========="
sudo apt-fast install -y nodejs

##
## ZSH
##
echo "=========[INSTALLING zsh]========="
sudo apt-get install -y zsh
##apt-fast completions for zsh
cp completions/zsh/_apt-fast /usr/share/zsh/functions/Completion/Debian/
chown root:root /usr/share/zsh/functions/Completion/Debian/_apt-fast
source /usr/share/zsh/functions/Completion/Debian/_apt-fast
##Setup Prezto
echo "=========[INSTALLING Prezto]========="
git clone --recursive https://github.com/ravishi/prezto.git "$HOME/.zprezto"

shopt -s extglob
for rcfile in $HOME/.zprezto/runcoms/!(README.md); do
  ln -s "$rcfile" "$HOME/.$(basename $rcfile)"
done

sudo usermod -s /bin/zsh "$(whoami)"

## 
## Setup VIM
##
echo "=========[INSTALLING Vim]========="
sudo apt-fast install -y vim
sudo update-alternatives --set editor /usr/bin/vim.basic

# Clone vim dotfile
echo "=========[Retrieving dotfiles for VIM]========="
#git clone --recursive https://github.com/drkarl/dotvim "$HOME/.vim"

# symlink vimrc
ln -s "$HOME/.vim/vimrc" "$HOME/.vimrc"

# powerline fancy symbols
echo "=========[Installing Powerline symbols]========="
mkdir -p "$HOME/.fonts/" "$HOME/.config/fontconfig/conf.d/"
wget -P "$HOME/.fonts/" https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf
sudo fc-cache -vf "$HOME/.fonts"
wget -P "$HOME/.config/fontconfig/conf.d/" https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf


# Better font rendering (aka Infinality)
# source: http://www.webupd8.org/2013/06/better-font-rendering-in-linux-with.html
echo "=========[INSTALLING Infinality]========="
sudo add-apt-repository -y ppa:no1wantdthisname/ppa \
    && sudo apt-fast update \
    && sudo apt-fast install -y fontconfig-infinality

# Turn off apport
echo "=========[DISABLING apport]========="
sudo su -c 'echo "enabled=0" > /etc/default/apport'

# -----------------------------------------------------------------------------
# => Get dotfiles
# -----------------------------------------------------------------------------
echo "=========[Retrieving dotfiles]========="
echo '=> Get dotfiles (http://github.com/drkarl/dotfiles)'
# Create a tmp folder with random name
dotfiles_path="`(mktemp -d)`"
 
# Clone the repository recursively
#git clone --recursive https://github.com/drkarl/dotfiles.git "$dotfiles_path"
#cd "$dotfiles_path"
 
# Copy all dotfiles except .git/ and .gitmodules
#cp -r `ls -d .??* | egrep -v '(.git$|.gitmodules)'` $HOME

##
## Create and enable swap file
##
echo "=========[Creating and enabling SWAP file]========="
sudo fallocate -l 4G /swapfile
sudo chown root:root /swapfile 
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
echo '/swapfile   none    swap    sw    0   0' | sudo tee -a /etc/fstab
echo 10 | sudo tee /proc/sys/vm/swappiness
echo vm.swappiness = 10 | sudo tee -a /etc/sysctl.conf

##
##Install nginx
##
echo "=========[INSTALLING nginx]========="
sudo apt-fast install -y nginx
sudo service nginx stop

##
##UFW
##
echo "=========[INSTALLING ufw]========="
sudo apt-fast install -y ufw
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
sudo ufw --force enable

##
##fail2ban
##
echo "=========[INSTALLING fail2ban]========="
sudo apt-fast install -y fail2ban
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
sudo service fail2ban restart
 
##
##Dist-upgrade
##
echo "=========[dist-upgrade]========="
sudo apt-fast update && sudo apt-fast dist-upgrade -y

##
#Cleanup
##
echo "=========[CLEANUP]========="
sudo apt-get autoremove -y
