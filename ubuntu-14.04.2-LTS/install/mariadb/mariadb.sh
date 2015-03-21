#MariaDB is a drop-in replacement for MySQL, with better performance, more features, and a better Community since it´s not owned by Oracle.

sudo apt-fast install -y software-properties-common
sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db
sudo add-apt-repository 'deb http://mirror.jmu.edu/pub/mariadb/repo/10.1/ubuntu trusty main'
sudo apt-fast update
sudo apt-fast install -y mariadb-server
/usr/bin/mysql_secure_installation
