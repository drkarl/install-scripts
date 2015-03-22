#Requires Java
#Requires an application server, Tomcat, Jetty, Glassfish, etc
echo -e "\033[1;33m=                                     =\033[0m"
echo -e "\033[1;33m=========[INSTALLING GitBucket]========\033[0m"
echo -e "\033[1;33m=                                     =\033[0m"
#webapps folder depends on the app container

#Jetty
webapps=/opt/jetty/webapps

#Tomcat
#webapps=/opt/tomcat/webapps

aria2c -s5 https://github.com/takezoe/gitbucket/releases/download/3.0/gitbucket.war
sudo mv gitbucket $webapps
echo -e "\033[1;32mGitbucket has been installed correctly\033[0m"
