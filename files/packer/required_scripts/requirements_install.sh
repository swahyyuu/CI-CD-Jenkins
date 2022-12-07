#!/bin/bash -x 

echo "Welcome to Packer"
echo "Docker installing..."
sudo mkdir /home/wahyu
sudo mv /home/ubuntu/docker.sh /home/wahyu
chmod +x /home/wahyu/docker.sh
bash /home/wahyu/docker.sh