# Post installation scripts for ubuntu

- Execute first `ubuntu-14.04.2-LTS/root/00-run_all.sh` as root.
The last part will add a user with sudo rights with the username you provide.

- Logout and login as the newly created user.

- Then, execute `ubuntu-14.04.2-LTS/user/00-run_all.sh` 

- Finally, logout and login again with that user, and execute `ubuntu-14.04.2-LTS/user/05-ruby-tmuxinator.sh`.

- Optionally there are some installation scripts for some other applications which will be added over time.

## What does it contain?

## **root** scripts

- Installs and starts [etckeeper](https://github.com/joeyh/etckeeper)

- Installs [apt-fast](https://github.com/ilikenwf/apt-fast) and from that point on, all apt-get commands use apt-fast
It installs apt-fast from github and not from Ubuntu repos because the version in Ubuntu repos uses bazaar by default, and the version on github uses git as default.

- Updates and Upgrades ubuntu.

- Installs some basic stuff (build-essentials, htop, molly-guard, python-dev which is required by stormssh, etc)

- Installs [tmux](http://tmux.sourceforge.net/)
If you don't know about tmux, it's a terminal multiplexer with awesome powers. If you use Screen, maybe you want to switch... There's also [byobu](http://byobu.co/), but this script only installs tmux.

- Installs [NodeJS](https://nodejs.org/)

- Installs Vim

- Installs Infinality for better font rendering

- Disables Ubuntu apport

- Creates and enables a swap file since in Digital Ocean there is no swap file by default. If you don't need a swap file or you use a VPS provider/server/laptop which already has a swap file you can fork and comment/remove this.

- Installs [nginx](http://nginx.org/)

- Installs ufw (iptables is too complex) and configures it by default to block incoming and allow outgoing, then allow ssh on port 22 (if you use a different ssh port you may want to change this).

- Installs fail2ban.

- Installs [stormssh](http://storm.readthedocs.org/en/latest/)

- dist-upgrade and autoremove.


## User creation script

This script assumes that there is one or more authorized public keys on `/root/.ssh/authorized_keys`. If you use Digital Ocean, there is an option to add some public keys to your account and easily deploy your public keys to the root user to any new server you create. Otherwise you can copy the keys manually.

- This first asks for a username for the user that will be created, who will be in the admin group, so it will have sudo privileges.

- Then it copies the `authorized_keys` file to /home/$user/.ssh


## User scripts

The user scripts

- Configure the Name and email for git.

- Disables root login and password authentication, and allows only the logged in user to login

- Sets VIM as default editor

- Installs zsh

- Installs prezto

- Installs the Powerline symbols

- Clones the dotfiles repo of the provided user and copies them to ~

- Clones the Tmux plugin manager. Remember to use prefix + I on tmux to install the plugins defined on your .tmux.conf

- Installs RVM. Requires user logout and login again.

Once the user has logged out and in again it can execute another cript to:

- Install Ruby

- Install [Tmuxinator](https://github.com/tmuxinator/tmuxinator)

## Optional installation scripts

This section will be growin overtime. For now there is:

- Taskwarrior server

- Taskwarrior client. The client is cloned and compiled because the version in Ubuntu repos can't use a Taskwarrior server, only works locally

- Tarsnap client

- Duplicity

- Jetty

- GitBucket
