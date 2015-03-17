#!/bin/bash
##
# Ubuntu post-install script
##

echo -e "\033[1;32mStarting post-installation script\033[0m"
##
##etc-keeper
##
echo -e "\033[1;33m=                                     =\033[0m"
echo -e "\033[1;33m=========[INSTALLING etckeeper]=========\033[0m"
echo -e "\033[1;33m=                                     =\033[0m"
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
## From now on, all other scripts assume apt-fast is installed
echo -e "\033[1;33m=                                     =\033[0m"
echo -e "\033[1;33m=========[INSTALLING apt-fast]=========\033[0m"
echo -e "\033[1;33m=                                     =\033[0m"
sudo apt-get install -y aria2
cd ~/
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
echo -e "\033[1;33m=                                 =\033[0m"
echo -e "\033[1;33m=======[Update and Upgrade]========\033[0m"
echo -e "\033[1;33m=                                 =\033[0m"
sudo apt-fast update -y && sudo apt-fast upgrade -y

##
##Essentials
##
echo -e "\033[1;33m=                                 =\033[0m"
echo -e "\033[1;33m======[INSTALLING essentials]======\033[0m"
echo -e "\033[1;33m=                                 =\033[0m"
sudo apt-fast install -y --no-install-recommends build-essential fontconfig fonts-inconsolata unzip p7zip-full ack-grep htop tmux molly-guard 

##
##Install NodeJS
##
echo -e "\033[1;33m=                                 =\033[0m"
echo -e "\033[1;33m========[INSTALLING NodeJS]========\033[0m"
echo -e "\033[1;33m=                                 =\033[0m"
sudo apt-fast install -y nodejs

## 
## Setup VIM
##
echo -e "\033[1;33m=                                 =\033[0m"
echo -e "\033[1;33m==========[INSTALLING Vim]=========\033[0m"
echo -e "\033[1;33m=                                 =\033[0m"
sudo apt-fast install -y vim
sudo update-alternatives --set editor /usr/bin/vim.basic

# Better font rendering (aka Infinality)
# source: http://www.webupd8.org/2013/06/better-font-rendering-in-linux-with.html
echo -e "\033[1;33m=                                 =\033[0m"
echo -e "\033[1;33m======[INSTALLING Infinality]======\033[0m"
echo -e "\033[1;33m=                                 =\033[0m"
sudo add-apt-repository -y ppa:no1wantdthisname/ppa \
    && sudo apt-fast update \
    && sudo apt-fast install -y fontconfig-infinality

# Turn off apport
echo -e "\033[1;33m=                                 =\033[0m"
echo -e "\033[1;33m=========[DISABLING apport]========\033[0m"
echo -e "\033[1;33m=                                 =\033[0m"
sudo su -c 'echo "enabled=0" > /etc/default/apport'

##
## Create and enable swap file
##
echo -e "\033[1;33m=                                   =\033[0m"
echo -e "\033[1;33m====[Creating/enabling SWAP file]====\033[0m"
echo -e "\033[1;33m=                                   =\033[0m"
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
echo -e "\033[1;33m=                                 =\033[0m"
echo -e "\033[1;33m=========[INSTALLING nginx]========\033[0m"
echo -e "\033[1;33m=                                 =\033[0m"
sudo apt-fast install -y nginx
sudo service nginx stop

##
##UFW
##
echo -e "\033[1;33m=                                =\033[0m"
echo -e "\033[1;33m=========[INSTALLING ufw]=========\033[0m"
echo -e "\033[1;33m=                                =\033[0m"
sudo apt-fast install -y ufw
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
sudo ufw --force enable

##
##fail2ban
##
echo -e "\033[1;33m=                                 =\033[0m"
echo -e "\033[1;33m=======[INSTALLING fail2ban]=======\033[0m"
echo -e "\033[1;33m=                                 =\033[0m"
sudo apt-fast install -y fail2ban
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
sudo service fail2ban restart
 
##
##Dist-upgrade
##
echo -e "\033[1;33m=                                 =\033[0m"
echo -e "\033[1;33m===========[dist-upgrade]==========\033[0m"
echo -e "\033[1;33m=                                 =\033[0m"
sudo apt-fast update && sudo apt-fast dist-upgrade -y

##
#Cleanup
##
echo -e "\033[1;33m=                               =\033[0m"
echo -e "\033[1;33m============[CLEANUP]============\033[0m"
echo -e "\033[1;33m=                               =\033[0m"
sudo apt-get autoremove -y

echo -e "\033[1;32mPost-installation script complete!!\033[0m"
