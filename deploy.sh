#!/bin/sh
git clone -b monolith https://github.com/express42/reddit.git
cd reddit
boundle install
puma -d
ps aux | grep puma
