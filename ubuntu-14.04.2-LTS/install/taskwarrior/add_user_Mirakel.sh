#!/bin/bash
if [ -z "$1" ]
  then
    TASKD=../src/taskd
else 
	TASKD=$1
fi

if [ -z "$2" ]
  then
    ROOT=$PWD/root
else 
	ROOT=$2
fi

if [ -z "$3" ]
  then
    ROOT_CA=../pki/ca.cert.pem
else 
	ROOT_CA=$3
fi

if ! [ -z "$4" ] ; then
	if [ "$4" -ge 2048 ] ; then
		BITS=$4
	fi
fi


#read username and org from comandline
read -p "Username?`echo $'\n> '`" USER
read -p "Org?`echo $'\n> '`" ORGANIZATION

#create org if nessersary
$TASKD add --data $ROOT org $ORG >&2>/dev/null

#create user
$TASKD add --data $ROOT user --quiet $ORGANIZATION $USER 1> user.key

#find configs
$TASKD config --data $ROOT |grep  '^server ' >server

./generate.client $ORGANIZATION$USER
cd $PWD
mv $ORGANIZATION$USER.cert.pem $USER.cert
#cat `$TASKD config --data $ROOT |grep  '^client.cert '| sed -e 's/client.cert//'`>$USER.cert
cat $ORGANIZATION$USER.key.pem |sed -n '/-----BEGIN RSA PRIVATE KEY-----/,/-----END RSA PRIVATE KEY-----/p' >$USER.key

#if user-config already exists remove it
rm -rf $USER.taskdconfig

#Write to user-conf file
echo "username: "$USER>>$USER.taskdconfig
echo "org: "$ORG>>$USER.taskdconfig
cat user.key| sed 's/New user key:/user key:/g'>>$USER.taskdconfig
echo "server: "`cat server| sed 's/^server//g'|sed 's/^[ \t]*//'`>>$USER.taskdconfig
echo "Client.cert:">>$USER.taskdconfig
cat $USER.cert>>$USER.taskdconfig
echo "Client.key:">>$USER.taskdconfig
cat $USER.key>>$USER.taskdconfig
echo "ca.cert:">>$USER.taskdconfig
cat $ROOT_CA>>$USER.taskdconfig

#remove temp-files
rm -rf user.key server $USER.cert
rm -rf user.key server $USER.key


echo 
echo "You're ready!"
echo "Copy the "$USER.taskdconfig" to your device and don't forget to start the server"
#echo "./run"
