# create download directories
mkdir -p ~/build/jetty
cd ~/build/jetty
 
# download
version="9.2.10.v20150310"
aria2c -o jetty-distribution-$version.tar.gz -s5 "http://eclipse.org/downloads/download.php?file=/jetty/stable-9/dist/jetty-distribution-$version.tar.gz&r=1"

# extract the archive - creates directory jetty-distribution-....
tar -xvf jetty-distribution-$version.tar.gz
 
# rename jetty directory
sudo mv jetty-distribution-$version /opt/jetty
 
# create jetty user
sudo useradd -U -s /bin/false jetty
 
# Make the jetty directory be owned by the jetty user
sudo chown -R jetty:jetty /opt/jetty
 
#Create link for jetty.sh
sudo ln -s /opt/jetty/bin/jetty.sh /etc/init.d/jetty

# create /etc/default/jetty
sudo sh -c ' printf " 
JAVA_HOME=/usr/java/default # Path to Java
JETTY_HOME=/opt/jetty  #Path to Jetty
NO_START=0 # Start on boot
JETTY_HOST=0.0.0.0 # Listen to all hosts
JETTY_PORT=8080 # Run on this port
JETTY_USER=jetty # Run as this user
" > /etc/default/jetty'
 
# make webapps writable
sudo chmod o+w /opt/jetty/webapps

#Cleanup
rm -rf ~/build/jetty
 
# check if the installation settings are ok
sudo service jetty check
 
# the server runs on the default port of 8080
# http://localhost:8080/
# To let Jetty automatically start on reboot execute
sudo update-rc.d jetty defaults

# Start Jetty as service
#sudo service jetty start
 
# Stop Jetty as service
#sudo service jetty stop
 
# deploy an app
#cp myapp.war /opt/jetty/webapps
 
#In case port conflicts, you can check wich application is blocking port 8080
#sudo netstat -lnptu|grep ":8080"
 
# monitor jetty log files
#ls -l /opt/jetty/logs
