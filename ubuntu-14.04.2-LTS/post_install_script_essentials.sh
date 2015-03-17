#!/bin/bash
##
# Ubuntu post-install script
##

##
##etc-keeper
##
echo "=                                     ="
echo "=========[INSTALLING etckeeper]========="
echo "=                                     ="
sudo apt-get install -y git make
# We don't use apt-get install etckeeper because defaults to bazaar
# Version in github defaults to git
git clone https://github.com/joeyh/etckeeper.git
cd etckeeper
make install
etckeeper init
etckeeper commit "Initial commit."
cd ..
rm -rf etckeeper

##
##apt-fast
##
echo "=                                     ="
echo "=========[INSTALLING apt-fast]========="
echo "=                                     ="
sudo apt-get install -y aria2
git clone https://github.com/ilikenwf/apt-fast.git
cd apt-fast
sudo cp apt-fast /usr/bin/
sudo chmod +x /usr/bin/apt-fast
sudo cp completions/bash/apt-fast /etc/bash_completion.d/
     
## Add Node PPA
sudo curl -sL https://deb.nodesource.com/setup | sudo bash -

##
#Update repos and upgrade software
##
echo "=                                  ="
echo "=======[Update and Upgrade]========"
echo "=                                  ="
sudo apt-fast update -y && sudo apt-fast upgrade -y

##
##Essentials
##
echo "=                                 ="
echo "======[INSTALLING essentials]======"
echo "=                                 ="
sudo apt-fast install -y --no-install-recommends build-essential fontconfig fonts-inconsolata unzip p7zip-full ack-grep htop tmux molly-guard 

##
##Install NodeJS
##
echo "=                                 ="
echo "========[INSTALLING NodeJS]========"
echo "=                                 ="
sudo apt-fast install -y nodejs

##
## ZSH
##
echo "=                                 ="
echo "=========[INSTALLING zsh]========="
echo "=                                 ="
sudo apt-get install -y zsh
##apt-fast completions for zsh
sudo cp ~/apt-fast/completions/zsh/_apt-fast /usr/share/zsh/functions/Completion/Debian/
sudo chown root:root /usr/share/zsh/functions/Completion/Debian/_apt-fast
source /usr/share/zsh/functions/Completion/Debian/_apt-fast

## 
## Setup VIM
##
echo "=                                 ="
echo "==========[INSTALLING Vim]========="
echo "=                                 ="
sudo apt-fast install -y vim
sudo update-alternatives --set editor /usr/bin/vim.basic

# Better font rendering (aka Infinality)
# source: http://www.webupd8.org/2013/06/better-font-rendering-in-linux-with.html
echo "=                                 ="
echo "======[INSTALLING Infinality]======"
echo "=                                 ="
sudo add-apt-repository -y ppa:no1wantdthisname/ppa \
    && sudo apt-fast update \
    && sudo apt-fast install -y fontconfig-infinality

# Turn off apport
echo "=                                 ="
echo "=========[DISABLING apport]========"
echo "=                                 ="
sudo su -c 'echo "enabled=0" > /etc/default/apport'

##
## Create and enable swap file
##
echo "=                                   ="
echo "====[Creating/enabling SWAP file]===="
echo "=                                   ="
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
echo "=                                 ="
echo "=========[INSTALLING nginx]========"
echo "=                                 ="
sudo apt-fast install -y nginx
sudo service nginx stop

##
##UFW
##
echo "=                                ="
echo "=========[INSTALLING ufw]========="
echo "=                                ="
sudo apt-fast install -y ufw
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
sudo ufw --force enable

##
##fail2ban
##
echo "=                                 ="
echo "=======[INSTALLING fail2ban]======="
echo "=                                 ="
sudo apt-fast install -y fail2ban
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
sudo service fail2ban restart
 
##
##Dist-upgrade
##
echo "=                                 ="
echo "===========[dist-upgrade]=========="
echo "=                                 ="
sudo apt-fast update && sudo apt-fast dist-upgrade -y

##
#Cleanup
##
echo "=                               ="
echo "============[CLEANUP]============"
echo "=                               ="
sudo apt-get autoremove -y

echo "Post-installation script complete!!"
