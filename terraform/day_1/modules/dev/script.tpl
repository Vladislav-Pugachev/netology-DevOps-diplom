#!/bin/bash
sudo apt update
timeout 1m
sudo apt install git python pip -y
timeout 2m
git clone https://github.com/kubernetes-sigs/kubespray.git
timeout 1m
cd kubespray
sudo pip install -r requirements.txt
timeout 7m
cp -rfp inventory/sample inventory/mycluster
cp ~/hosts.yml inventory/mycluster/hosts.yml
sudo chown 0600 ~/.ssh/id_rsa
ansible-playbook -i inventory/mycluster/hosts.yml cluster.yml -b -v -e 'cluster_access_ip=${control_node_ext_ip}:6443'
timeout 20m
