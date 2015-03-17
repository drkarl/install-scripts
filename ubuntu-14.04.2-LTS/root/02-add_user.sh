#This script assumes it is run by root.
#Will create a user and copy the authorized_keys for root to that user

echo -e "\033[33;31mWarning, the user created now will have admin powers!\033[0m"
read -p "Continue (y/n)?" choice
case "$choice" in 
  y|Y ) echo "yes";;
  n|N ) exit 1;;
  * ) echo "invalid";;
esac

read -p "Enter username for new user: " username
echo -e "\033[33;33m=                               =\033[0m"
echo -e "\033[33;33m============[CLEANUP]============\033[0m"
echo -e "\033[33;33m=                               =\033[0m" 

echo -e "\033[33;33m=                                     =\033[0m"
echo -e "\033[33;33m============[ Adding user ]============\033[0m"
echo -e "\033[33;33m=                                     =\033[0m"
adduser $username

mkdir -p "/home/${username}/.ssh"

echo -e "\033[33;33m=                                     =\033[0m"
echo -e "\033[33;33m=========[ Copying ssh keys ]==========\033[0m"
echo -e "\033[33;33m=                                     =\033[0m"
mv /root/.ssh/authorized_keys "/home/${username}/.ssh/authorized_keys"

chown -R $username:$username "/home/${username}/.ssh/" 
chmod 700  "/home/${username}/.ssh/"
chmod 600  "/home/${username}/.ssh/authorized_keys"

echo -e "\033[33;33m=                                     =\033[0m"
echo -e "\033[33;33m======[ Adding user to suoders ]=======\033[0m"
echo -e "\033[33;33m=                                     =\033[0m"
usermod -a -G sudo ${username}

cp -R /root/install-scripts "/home/${username}/" 
cp -R /root/apt-fast "/home/${username}/" 
echo -e "\033[33;32mUser ${username} created, added to sudoers and keys setup\033[0m"