#!/bin/bash
set -e
APP_DIR=${1:-$HOME}
#sudo dpkg --configure -a
sudo apt update
sleep 30
sudo apt install -y git
git clone -b monolith https://github.com/express42/reddit.git $APP_DIR/reddit
cd $APP_DIR/reddit
bundle install
sudo mv /tmp/puma.service /etc/systemd/system/puma.service
sudo systemctl start puma
sudo systemctl enable puma
