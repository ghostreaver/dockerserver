#!/usr/bin/env bash

## Configure APT sources
## ---------------------
sudo add-apt-repository -y main && sudo add-apt-repository -y restricted && sudo add-apt-repository -y universe && sudo add-apt-repository -y multiverse

## Keep system safe
## ----------------
sudo apt -y update && sudo apt -y upgrade && sudo apt -y dist-upgrade
sudo apt -y remove && sudo apt -y autoremove
sudo apt -y clean && sudo apt -y autoclean

## Disable error reporting
## -----------------------
sudo sed -i "s/enabled=1/enabled=0/" /etc/default/apport

## Edit SSH settings
## -----------------
sudo sed -i "s/#Port 22/Port 49622/" /etc/ssh/sshd_config
sudo sed -i "s/#LoginGraceTime 2m/LoginGraceTime 2m/" /etc/ssh/sshd_config
sudo sed -i "s/#PermitRootLogin prohibit-password/PermitRootLogin no/" /etc/ssh/sshd_config
sudo sed -i "s/#StrictModes yes/StrictModes yes/" /etc/ssh/sshd_config
sudo systemctl restart ssh.service

## Install prerequisite packages
## -----------------------------
sudo apt -y install apt-transport-https ca-certificates curl git make software-properties-common

## Add the GPG key for the official Docker repository
## --------------------------------------------------
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

## Add the Docker repository to APT sources
## ----------------------------------------
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

## Update the packages list
## ------------------------
sudo apt -y update

## Install Docker-CE
## -----------------
sudo apt -y install docker-ce docker-ce-cli docker-compose containerd.io
sudo systemctl status docker

## Add your username to the docker group
## -------------------------------------
sudo usermod -aG docker ${USER}
su - ${USER}

## Reboot server
## -------------
sudo reboot now