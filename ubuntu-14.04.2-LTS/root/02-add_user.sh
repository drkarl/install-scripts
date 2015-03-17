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

echo "=                                     ="
echo "============[ Adding user ]============"
echo "=                                     ="
adduser $username

mkdir -p "/home/${username}/.ssh"

echo "=                                     ="
echo "=========[ Copying ssh keys ]=========="
echo "=                                     ="
mv /root/.ssh/authorized_keys "/home/${username}/.ssh/authorized_keys"

chown -R $username:$username "/home/${username}/.ssh/" 
chmod 700  "/home/${username}/.ssh/"
chmod 600  "/home/${username}/.ssh/authorized_keys"

echo "=                                     ="
echo "======[ Adding user to suoders ]======="
echo "=                                     ="
usermod -a -G sudo ${username}

mv /root/install-scripts "/home/${username}/" 
mv /root/apt-fast "/home/${username}/" 
echo -e "\033[33;32mUser ${username} created, added to sudoers and keys setup\033[0m"
