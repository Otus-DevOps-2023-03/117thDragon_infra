#!/bin/bash

apt-get update
sleep 30
apt-get install apt-utils
sleep 10
echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
apt-get install -y ruby-full ruby-bundler build-essential nano mc
