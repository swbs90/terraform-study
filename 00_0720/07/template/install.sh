#!/bin/bash
#install docker
sudo apt-get update -y
sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
"deb [arch=amd64] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) \
stable"
sudo apt-get update -y 
sudo apt-get install docker-ce docker-ce-cli containerd.io -y
#start docker
sudo systemctl enable docker 
sleep 10
sudo systemctl start docker
sleep 10
sudo docker run -p ${service_port}:80 -d nginx