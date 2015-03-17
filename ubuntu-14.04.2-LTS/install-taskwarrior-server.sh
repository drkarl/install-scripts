#!/bin/bash

#Install Task Warrior server
#replace drkarl by the user

apt-fast install -y git cmake gnutls-bin libgnutls-dev uuid-dev zip

mkdir git

cd git

git clone https://git.tasktools.org/scm/tm/taskd

cd taskd

sudo cmake . && sudo make && sudo make install

cd test && sudo make && sudo ./run_all

~/.profile 

echo "export TASKDDATA=/var/taskd" >> ~/.zshrc

export TASKDDATA=/var/taskd

sudo mkdir -p $TASKDDATA

chown drkarl:drkarl $TASKDDATA

taskd init

line="@reboot taskdctl start"
(crontab -u drkarl -l; echo "$line" ) | crontab -u drkarl -

cd ~/git/taskd/pki

./generate

cp client.cert.pem client.key.pem server.cert.pem server.key.pem server.crl.pem ca.cert.pem $TASKDDATA

taskd config --force client.cert $TASKDDATA/client.cert.pem && taskd config --force client.key $TASKDDATA/client.key.pem && taskd config --force server.cert $TASKDDATA/server.cert.pem && taskd config --force server.key $TASKDDATA/server.key.pem && taskd config --force server.crl $TASKDDATA/server.crl.pem && taskd config --force ca.cert $TASKDDATA/ca.cert.pem

taskd config --force log $TASKDDATA/log/taskd.log

taskd config --force pid.file $TASKDDATA/pid/taskd.pid

taskd config --force client.allow '^task [2-9],^taskd,^libtaskd,^Mirakel [1-9]'

#Choose one of the following lines, depending if ip or hostname
taskd config --force server `/sbin/ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}'`:53589
taskd config --force server `hostname`:53589

#Mirakel
#wget https://raw.githubusercontent.com/MirakelX/mirakel-scripts/master/add_user.sh
#chmod +x add_user.sh
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

taskdctl start
