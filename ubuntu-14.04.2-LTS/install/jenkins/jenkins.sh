#Requires Java
#This installs jenkins as a service and uses the embedded Jetty server
#Jenkins can also be installed as a war deployed to an application server
wget -q -O - https://jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update -y
sudo apt-fast install -y jenkins
