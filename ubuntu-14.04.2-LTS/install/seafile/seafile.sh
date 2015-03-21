

read -p "Enter organization name" organization

mkdir $organization


cd $organization
mkdir installed
mv seafile-server_*.tgz installed

version=4.0.6
aria2c "https://bitbucket.org/haiwen/seafile/downloads/seafile-server_${version}_x86-64.tar.gz"

# after moving seafile-server_* to this directory
tar -xzf seafile-server_*

# Install prerequisites
apt-fast update
apt-fast install -y python2.7 python-setuptools python-imaging python-mysqldb

cd seafile-server-*
./setup-seafile-mysql.sh  #run the setup script & answer prompted questions

ulimit -n 30000
./seafile.sh start # Start seafile service
./seahub.sh start   # Start seahub website, port defaults to 8000

#To change configuration, like the port, in $organization/ccnet/ccnet.conf

#To add memcached refer to http://manual.seafile.com/deploy/add_memcached.html
