#!/usr/bin/env bash
# TAKEN FROM: https://hostadvice.com/how-to/how-to-install-docker-on-debian-11-bullseye-system/

# Step 1: Uninstall or Remove old Docker packages:
sudo apt remove -y docker docker-engine docker.io containerd runc

# Step 2: Install HTTPS supportive packages:
sudo apt update
sudo apt install apt-transport-https ca-certificates curl gnupg2 software-properties-common

# Step 3: Import Docker’s repository GPG key:
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o/usr/share/keyrings/docker-archive-keyring.gpg

# Step 4: Add Docker’s repository:
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list

# Step 5: Refresh the packages index after adding the docker’s repository:
sudo apt update

# Step 6: Install Docker CE on Debian 11 system:
sudo apt install -y docker-ce docker-ce-cli containerd.io

# Step 7: Check installed Docker version:
docker -v

# Step 8: Grant permissions to non-root users to run Docker commands:
sudo groupadd docker
sudo usermod -aG docker $USER

# Step 9: Reboot your terminal.
echo "READY. Reboot or log out from the terminal!"