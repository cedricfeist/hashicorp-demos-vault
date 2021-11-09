#!/usr/bin/env bash

#Set URL and version
export VAULT_URL="https://releases.hashicorp.com/vault" VAULT_VERSION="1.8.4+ent"

#Download Vault
curl \
    --silent \
    --remote-name \
   "${VAULT_URL}/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip"

#Update
sudo apt-get update -y
#Unzip
sudo apt-get install -y unzip
unzip vault_${VAULT_VERSION}_linux_amd64.zip
#Install jq
sudo apt install -y jq
#Install pip + get demo app repo
sudo apt install -y python3-pip
pip3 install -r transit-app-example/backend/requirements.txt 
#git clone https://github.com/assareh/transit-app-example.git
#Install MySQL
sudo apt install -y mysql-server
#Setup root password for mysql
sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH caching_sha2_password BY 'R00tPassword';"
#Owner of Binary
sudo chown root:root vault
#Set system path
sudo mv vault /usr/local/bin/
#Set profile
cat ./profile.txt >> .bashrc
#Set permissions
chmod 700 -R ./0*
#Remove .zip
rm -rf vault_${VAULT_VERSION}_linux_amd64.zip
