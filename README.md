# 117thDragon_infra
117thDragon Infra repository

##### H/W #5 codename "Bastion"
bastion_IP = 158.160.60.25
bastion = https://158.160.60.25.sslip.io
someinternalhost_IP = 10.128.0.15

********************************************
#### preparation ssh ProxyJump
###not required "ssh-add -L"
eval $(ssh-agent -s)
ssh-add ~/.ssh/appuser
ssh -J appuser@158.160.41.177 appuser@10.128.0.15

# ~/.ssh/config
Host *
  ForwardAgent yes

Host bastion
  Hostname %ip-bastion-vm%
  User appuser
  Port 22
  IdentityFile ~/.ssh/appuser

Host someinternalhost
  Hostname %ip-dmz-vm%
  User appuser

## sample for ProxyJump
ProxyJump appuser@%ip-bastion-vm%

## sample for ProxyCommand
ProxyCommand ssh -W %h:%p  %ip-bastion-vm%

ssh someinternalhost
********************************************

P.S. Скрипт "setupvpn.sh" отработал некорректно.
Устаревшие ключи gp и репозиторий. После установки не стартовал mangodb service и так же не хватало компонентов pritunl.
Manual install:
#!/bin/sh
apt install -y wget vim curl gnupg2 software-properties-common apt-transport-https ca-certificates lsb-release
tee /etc/apt/sources.list.d/pritunl.list << EOF
deb https://repo.pritunl.com/stable/apt jammy main
EOF
apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 7568D9BB55FF9E5287D586017AE645C0CF8E292A
echo "deb http://security.ubuntu.com/ubuntu focal-security main" | sudo tee /etc/apt/sources.list.d/focal-security.list
sudo apt update
sudo apt install libssl1.1
wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/6.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list
sudo apt update && sudo apt install pritunl mongodb-org
sudo systemctl start pritunl mongod
sudo systemctl enable pritunl mongod
