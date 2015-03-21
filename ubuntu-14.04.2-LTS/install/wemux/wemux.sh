sudo git clone git://github.com/zolrath/wemux.git /usr/local/share/wemux
sudo ln -s /usr/local/share/wemux/wemux /usr/local/bin/wemux
sudo cp /usr/local/share/wemux/wemux.conf.example /usr/local/etc/wemux.conf

#set a user to be a wemux host by adding their username to the host_list in /usr/local/etc/wemux.conf
#like ths host_list=(zolrath brocksamson)
