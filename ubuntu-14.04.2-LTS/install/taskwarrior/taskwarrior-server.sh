#!/bin/bash
username=`whoami`

#Install Task Warrior server

apt-fast install -y git cmake gnutls-bin libgnutls-dev uuid-dev zip

git clone https://git.tasktools.org/scm/tm/taskd ~/taskd
cp add_user_Mirakel.sh ~/taskd/pki
cd ~/taskd
sudo cmake . && sudo make && sudo make install
cd test && sudo make && sudo ./run_all

#Switch comments if using bash
#echo "export TASKDDATA=/var/taskd" >> ~/.profile
echo "export TASKDDATA=/var/taskd" >> ~/.zshrc

export TASKDDATA=/var/taskd

sudo mkdir -p $TASKDDATA

sudo chown $username:$username $TASKDDATA

taskd init

line="@reboot taskdctl start"
(crontab -u "$username" -l; echo "$line" ) | crontab -u $username -

cd ~/taskd/pki

./generate

cp client.cert.pem client.key.pem server.cert.pem server.key.pem server.crl.pem ca.cert.pem $TASKDDATA

taskd config --force client.cert $TASKDDATA/client.cert.pem && taskd config --force client.key $TASKDDATA/client.key.pem && taskd config --force server.cert $TASKDDATA/server.cert.pem && taskd config --force server.key $TASKDDATA/server.key.pem && taskd config --force server.crl $TASKDDATA/server.crl.pem && taskd config --force ca.cert $TASKDDATA/ca.cert.pem

taskd config --force log $TASKDDATA/log/taskd.log

taskd config --force pid.file $TASKDDATA/pid/taskd.pid

taskd config --force client.allow '^task [2-9],^taskd,^libtaskd,^Mirakel [1-9]'

#Choose one of the following lines, depending if ip or hostname
taskd config --force server `/sbin/ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}'`:53589
taskd config --force server `hostname`:53589

taskdctl start
sudo ufw allow 53589/tcp
#Mirakel

echo -e "\033[1;32mFrom here on it is better to do things manually\033[0m"
echo -e "\033[1;32mThere are some commented commands on the script as a guide\033[0m"
#./add_user.sh

#taskd add org <org_name>

#taskd add user '<org_name>' '<first last>'

#cd ~/git/taskd/pki

#./generate.client <unique_name_for_computer> #first_last_hostname
#zip <unique_name_for_computer>.zip ca.cert.pem <unique_name_for_computer>*
#mv <unique_name_for_computer>.zip ~/

#FROM CLIENT
#scp user@domain:<unique_name_for_computer>.zip ~/.task
#unzip ~/.task/<unique_name_for_computer>.zip
#rm ~/.task/<unique_name_for_computer>.zip

#Few extra steps

