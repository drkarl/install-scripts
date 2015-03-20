echo "\033[1;33m=                                     =\033[0m"
echo "\033[1;33m===========[INSTALLING attic]==========\033[0m"
echo "\033[1;33m=                                     =\033[0m"
sudo apt-fast install -y build-essential python3-pip libssl-dev python-dev libevent-dev uuid-dev libacl1-dev liblzo2-dev
sudo pip3 install attic
echo "\033[1;32mAttic backup has been installed correctly\033[0m"
