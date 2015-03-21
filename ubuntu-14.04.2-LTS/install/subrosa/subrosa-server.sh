#Requires nodejs and npm
git clone https://github.com/subrosa-io/subrosa-server.git
cd subrosa server
npm install
mysql -u root < structure.sql
cp config.sample.js config.js
