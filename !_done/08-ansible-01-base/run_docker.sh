#!/bin/bash
docker rm $(docker ps -aqf "name=fedora") -f
docker run --name fedora -d  pycontribs/fedora  bash -c "sleep 6000000" 
docker rm $(docker ps -aqf "name=ubuntu") -f
docker run --name ubuntu -d ubuntu bash -c "sleep 6000000"
docker rm $(docker ps -aqf "name=centos7") -f
docker run --name centos7 -d prairielearn/centos7-python  bash -c "sleep 6000000" 
ansible-playbook site.yml -i inventory/prod.yml 
docker rm $(docker ps -aqf "name=fedora") -f
docker rm $(docker ps -aqf "name=ubuntu") -f
docker rm $(docker ps -aqf "name=centos7") -f