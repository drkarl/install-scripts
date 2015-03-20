echo -e "\033[1;33m=                                     =\033[0m"
echo -e "\033[1;33m=========[INSTALLING tarsnap]==========\033[0m"
echo -e "\033[1;33m=                                     =\033[0m"
wget https://www.tarsnap.com/download/tarsnap-autoconf-1.0.35.tgz
wget https://www.tarsnap.com/download/tarsnap-sigs-1.0.35.asc


echo -e "\033[1;33mVerify that the source code has not been tampered with\033[0m"
gpg --keyserver hkp://keys.gnupg.net --recv-keys 0x46B64BEB
gpg --fingerprint 0x46B64BEB
gpg --decrypt tarsnap-sigs-1.0.35.asc
sha256sum tarsnap-autoconf-1.0.35.tgz

tar xvzf tarsnap-autoconf-1.0.35.tgz
apt-fast install libssl-dev zlib1g-dev e2fslibs-dev 
cd tarsnap-autoconf-1.0.35
./configure
sudo make all install clean
cd ..
rm -rf tarsnap-autoconf-1.0.35
rm -rf tarsnap-autoconf-1.0.35.tgz
rm -rf tarsnap-sigs-1.0.35.asc
echo -e "\033[1;32mTarsnap has been installed correctly\033[0m"
