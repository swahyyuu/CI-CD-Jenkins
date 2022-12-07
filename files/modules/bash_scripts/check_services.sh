#!/bin/bash

function check_docker() {
  systemctl is-active --quiet docker
  if [[ $? -ne 0 ]]; then
    sudo systemctl start docker
  fi
}

check_docker

sudo docker version
{
sudo docker run -d -p 80:80 --name flask_application $1/jenkins:3.1
} || { 
sudo docker run -d -p 80:80 --name flask_application ${dockerhub_user}/jenkins:3.1
}
wait
sudo docker container ls