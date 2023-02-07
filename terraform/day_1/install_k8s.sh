#!/bin/bash
sudo apt update
timeout 1m
sudo apt install git python pip -y
timeout 2m
git clone https://github.com/kubernetes-sigs/kubespray.git
timeout 1m
cd kubespray
sudo pip3 install -r requirements.txt
cp -rfp inventory/sample inventory/mycluster
cp ~/host.yml inventory/mycluster/host.yml
sudo chown 0600 ~/.ssh/id_rsa
ansible-playbook -i inventory/mycluster/hosts.yaml cluster.yml -b -v -e 'cluster_access_ip=84.201.173.178:6443'
