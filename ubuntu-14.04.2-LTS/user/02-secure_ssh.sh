#Basic configuration to secure SSH

echo -e "\033[33;31mWarning, if you continue the root user won't be able to login anymore!\033[0m"
read -p "Continue (y/n)?" choice
case "$choice" in
  y|Y ) echo "yes";;
  n|N ) exit 1;;
  * ) echo "invalid";;
esac

# root can't login
sudo sed -i -e '/^PermitRootLogin/s/^.*$/PermitRootLogin no/' /etc/ssh/sshd_config

# Password authentication forbidden
sudo sed -i -e '/^#PasswordAuthentication/s/^.*$/PasswordAuthentication no/' /etc/ssh/sshd_config

# Allow login to the current user
sudo sed -i -e '$aAllowUsers `whoami`' /etc/ssh/sshd_config  

# OPTIONAL - Change standard SSH port (22)
# sudo sed -i -e '/^Port/s/^.*$/Port 2222/' /etc/ssh/sshd_config

sudo restart ssh
echo -e "\033[33;32mRoot can't login anymore, and only keys, no passwords, can be used!\033[0m"
