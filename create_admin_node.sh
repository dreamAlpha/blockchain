#!/bin/bash

sudo apt update &&

sudo apt install git &&

curl -L https://www.opscode.com/chef/install.sh | sudo bash &&

git clone https://github.com/avitenzer/db-chef.git &&

cd db-chef/node-linux &&

sudo sh newchain &&
