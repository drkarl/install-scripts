echo "\033[1;33m=                                     =\033[0m"
echo "\033[1;33m=========[INSTALLING duplicity]========\033[0m"
echo "\033[1;33m=                                     =\033[0m"
sudo add-apt-repository -y ppa:duplicity-team/ppa
sudo apt-fast update -y
sudo apt-fast install -y duplicity
cd && git clone https://github.com/zertrin/duplicity-backup.git
sudo cp ~/duplicity-backup/duplicity-backup.conf.example /etc/duplicity-backup.conf

echo "\033[1;32mDuplicity has been installed correctly\033[0m"
echo "\033[1;32mduplicity-backup is a shell script to simplify and automate it\033[0m"
# Start a backup
#cd ~/duplicity-backup
#./duplicity-backup.sh -c /etc/duplicity-backup.conf --backup
