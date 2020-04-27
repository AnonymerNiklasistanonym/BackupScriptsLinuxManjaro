#!/usr/bin/env bash
set -x

sudo gpasswd -a $USER docker
sudo systemctl start docker
sudo docker run hello-world

