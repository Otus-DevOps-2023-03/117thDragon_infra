# 117thDragon_infra
117thDragon Infra repository

# H/W #5 codename "Bastion"
bastion_IP = 158.160.60.25
someinternalhost_IP = 10.128.0.15

#preparation ssh ProxyJump
eval $(ssh-agent -s)
ssh-add ~/.ssh/appuser
ssh -J appuser@158.160.41.177 appuser@10.128.0.15

~/.ssh/config
Host * ForwardAgent yes

Host bastion
Hostname %ip-bastion-vm%
User appuser Port 22
IdentityFile ~/.ssh/appuser

Host someinternalhost
Hostname %ip-dmz-vm%
User appuser

sample for ProxyJump
ProxyJump appuser@%ip-bastion-vm%

sample for ProxyCommand
ProxyCommand ssh -W %h:%p %ip-bastion-vm%

ssh someinternalhost


# H/W #6 codename "TestApp"

testapp_IP = 158.160.99.237
testapp_port = 9292

Использовались команды cli yc:
yc config list
yc config profile list
yc compute instance list
yc compute instance get ИмяИнстанса
yc compute instance delete ИмяИнстанса

url приложения:
http://158.160.99.237:9292/

yaml файл с доп. параметрами деплоя:
--metadata-from-file user-data=metadata.yaml

используемые скрипты:
install_ruby.sh		- установка ruby
install_mongodb.sh	- установка mongodb
deploy.sh		- скачиваение и запуск приложения с репозитория git
startup.sh		- вызов предыдущих трех скриптов
metadata.yaml		- доп. параметры деплоя инстанса
deploy_instance.sh	- скрипт деплоя инстанса
