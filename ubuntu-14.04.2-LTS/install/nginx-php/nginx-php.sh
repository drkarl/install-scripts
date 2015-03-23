sudo apt-fast install -y php5-fpm php5-memcache php5-xcache memcached 

sudo sed -i -e 's/^;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/' /etc/php5/fpm/php.ini

sudo sed -i -e 's/^upload_max_filesize.*/upload_max_filesize=64M/' /etc/php5/fpm/php.ini

sudo sed -i -e 's/^post_max_size.*/post_max_size =64M/' /etc/php5/fpm/php.ini

sudo service php5-fpm restart

echo "\033[1;31mEdit etc/nginx/sites-available/default\033[0m"

sudo service nginx restart

echo "\033[1;32mDeploy to /usr/share/nginx/\033[0m"

# Refer to https://www.digitalocean.com/community/tutorials/how-to-install-linux-nginx-mysql-php-lemp-stack-on-ubuntu-14-04
