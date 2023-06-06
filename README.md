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

# H/W #7 codename "packer"

1) Изучен процесс установки packer
2) Создан сервисный аккаунт для работы с yc
3) Сервисному аккаунту делегированы права роли "editor"
4) Создан IAM key
5) Создан файл шаблона "ubuntu16.json"
6) Изучил командфы проверки и построения образа на основании json-шаблона packer (packer validate и build)
7) Изучены доп. параметры шаблона packer: "zone" - зона доступности; "subnet_id" - идентификатор подсети; "use_ipv4_nat"; "image_description"; "disk_type";
8) Создан bake-image
9) Создан скрипт create-reddit-vm.sh разворачивающий инстанс на основе ранее созданного образа
./packer/ubuntu16.json - шаблон образа packer
./packer/immutable.json - шаблон bake-образа (с автозапуском сервиса)
./packer/files/puma.service - доставляемый в шаблон файл сервиса для последующей инициализации starup puma.service
В скриптах использованы паузы в связи с наблюдаемой проблемой производительности (система не всегда успевает стартовать сервис или демона).
~/config-scripts/create-reddit-vm.sh - скрипт деплоя инстанса на основе ранее созданного образа.
