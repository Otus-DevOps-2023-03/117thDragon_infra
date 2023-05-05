# 117thDragon_infra
117thDragon Infra repository

##### H/W #5 codename "Bastion"
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
