#Basic configuration to secure SSH

# root can't login
sudo sed -i -e '/^PermitRootLogin/s/^.*$/PermitRootLogin no/' /etc/ssh/sshd_config

# Password authentication forbidden
sudo sed -i -e '/^#PasswordAuthentication/s/^.*$/PasswordAuthentication no/' /etc/ssh/sshd_config

# Allow login to the current user
sudo sed -i -e '$aAllowUsers `whoami`' /etc/ssh/sshd_config  

# OPTIONAL - Change standard SSH port (22)
# sudo sed -i -e '/^Port/s/^.*$/Port 2222/' /etc/ssh/sshd_config

sudo restart ssh
