# SantikaS_infra
SantikaS Infra repository

##Connection to one command: ssh -i ~/.ssh/appuser -A appuser@51.250.82.44 -p 2222
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
ssh -i ~/.ssh/appuser -A appuser@51.250.82.44 -p 2222

##Connection by alias someinternalhost
nano ~/.ssh/config
##Add to file
Host someinternalhost
    HostName 51.250.82.44
    User appuser
    IdentityFIle ~/.ssh/appuser
    Port 2222

##Checking
ssh someinternalhost
