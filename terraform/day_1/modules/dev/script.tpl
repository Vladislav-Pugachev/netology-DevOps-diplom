#!/bin/bash
sudo apt update
sudo apt install git python pip -y
git clone https://github.com/kubernetes-sigs/kubespray.git
cd kubespray
sudo pip install -r requirements.txt
cp -rfp inventory/sample inventory/mycluster
cp ~/hosts.yml inventory/mycluster/hosts.yml
sudo chown 0600 ~/.ssh/id_rsa
ansible-playbook -i inventory/mycluster/hosts.yml cluster.yml -b -v -e 'cluster_access_ip=${nat_ext_ip}:6443'
