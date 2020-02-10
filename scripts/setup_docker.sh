#!/usr/bin/env bash

sudo gpasswd -a $USER docker
sudo systemctl start docker
sudo docker run hello-world

