# SantikaS_infra
SantikaS Infra repository

##Connection to one command: ssh -i ~/.ssh/appuser -A appuser@51.250.94.202 -p 2222
##On bastion host:
##Turn on ipv4_forwarding
sudo nano /etc/sysctl.conf
##Uncomment #net.ipv4.ip_forward=1
net.ipv4.ip_forward=1
##Save and exit.
##Further apply.
sudo sysctl -p
##Forwarding port 2222 from bastion to port 22 of someinternalhost
sudo iptables -t nat -A PREROUTING -p tcp --dport 2222 -j DNAT --to 10.128.0.35:22
sudo iptables -t nat -A POSTROUTING -o eth0 -p tcp --dport 22 -d 10.128.0.35 -j SNAT --to 10.128.0.25:2222
##Save iptables
sudo apt install iptables-persistent
sudo service netfilter-persistent save
##Checking
sudo iptables -t nat -L

##On local host:
##Checking:
ssh -i ~/.ssh/appuser -A appuser@51.250.94.202 -p 2222

##Connection by alias someinternalhost
nano ~/.ssh/config
##Add to file
Host someinternalhost
    HostName 51.250.94.202
    User appuser
    IdentityFIle ~/.ssh/appuser
    Port 2222

##Checking
ssh someinternalhost


##VPN Connect configuration
bastion_IP = 51.250.94.202
someinternalhost_IP = 10.128.0.35

##DZ N4
testapp_IP = 178.154.207.23
testapp_port = 9292

##Add script startup.sh and metadata.yaml
##Run script
bash startup.sh


##DZ N5
http://84.201.167.175:9292/
## Create image VM with Packer
## Create script ubuntu 16.json
## Create script variables.json with add to .gitignore
## Create script variable.json.examples
## Create script immutable.json
## Create script create-reddit-vm.sh

##DZ N6
##ip APP:
http://51.250.84.123:9292/
##ip balancer:
http://51.250.89.147:8080/
## Create directory terraform
## Create file main.tf
## Create outputs.tf
## Create script files/deploy.sh
## Create variables.tf
## Create terraform.tfvars
## Create terraform.tfvars.example
## Create lb.tf **

##DZ Т7
## URL APP:
http://84.201.174.58:9292
## Create modules app, db, vpc
## Create stage & prod
## Create backend.tf
## Add provisioners to modules
## Correct DATABASE_URL

##DZ N8
## Create inventory file
## Create ansible.cfg
## Change inventory
## Create inventory.yml
## Create playbook clone.yml
## Create inventory.json *
## Change ansible.cfg
## Create inventory.sh
