#This script assumes it is run by root.
#Will create a user and copy the authorized_keys for root to that user

read -p "Enter username for new user: " username

echo "=                                     ="
echo "============[ Adding user ]============"
echo "=                                     ="
adduser $username

mkdir -p "/home/${username}/.ssh"

echo "=                                     ="
echo "=========[ Copying ssh keys ]=========="
echo "=                                     ="
cp /root/.ssh/authorized_keys "/home/${username}/.ssh/authorized_keys"

chown -R $username:$username "/home/${username}/.ssh/" 
chmod 700  "/home/${username}/.ssh/"
chmod 600  "/home/${username}/.ssh/authorized_keys"

echo "=                                     ="
echo "======[ Adding user to suoders ]======="
echo "=                                     ="
usermod -a -G sudo ${username}
