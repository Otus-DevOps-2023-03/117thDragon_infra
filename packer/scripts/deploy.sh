#!/bin/bash

apt-get install -y git
git clone -b monolith https://github.com/express42/reddit.git
cd reddit
bundle install
sleep 30
puma -d
