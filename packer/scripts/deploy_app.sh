#!/bin/bash

echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list
apt-get update
sleep 15
apt-get install -y apt-utils mc nano ruby-full ruby-bundler build-essential git mongodb-org
sleep 30
systemctl start mongod
systemctl enable mongod
cp /tmp/puma.service /etc/systemd/system/puma.service
git clone -b monolith https://github.com/express42/reddit.git
cd reddit
bundle install
puma -d
chmod 755 /etc/systemd/system/puma.service
systemctl enable puma.service
systemctl start puma.service
