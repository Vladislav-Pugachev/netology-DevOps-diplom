- apt install openvpn easy-rsa
### CA
``` 
mkdir easy-rsa 
ln -s /usr/share/easy-rsa/* ~/easy-rsa/ 
sudo chown pugachevvv ~/easy-rsa 
chmod 700 easy-rsa/ 
vi easy-rsa/vars
```

```
set_var EASYRSA_REQ_COUNTRY    "RU"
set_var EASYRSA_REQ_PROVINCE   "Respublica Bashkortostan"
set_var EASYRSA_REQ_CITY       "Ufa"
set_var EASYRSA_REQ_ORG        "Netology"
set_var EASYRSA_REQ_EMAIL      "pugachevvv@gmail.com"
set_var EASYRSA_REQ_OU         "Diplom"
set_var EASYRSA_ALGO           "ec"
set_var EASYRSA_DIGEST         "sha512"
```

```
cd easy-rsa

./easyrsa init-pki
./easyrsa build-ca
./easyrsa gen-req netology_diplom nopass

./easyrsa sign-req server netology_diplom
sudo cp ./pki/ca.crt /etc/openvpn/server
sudo cp ./pki/issued/netology_diplom.crt /etc/openvpn/server
sudo cp ./pki/private/netology_diplom.key /etc/openvpn/server
./easyrsa gen-dh
sudo openvpn --genkey --secret ta.key
sudo cp ~/easy-rsa/ta.key /etc/openvpn/server
sudo cp ~/easy-rsa/pki/dh.pem /etc/openvpn/
./easyrsa gen-req vlad nopass
mkdir -p ~/client-configs/keys
cp ./pki/private/vlad.key ~/client-configs/keys/
./easyrsa sign-req client vlad
cp ./pki/issued/vlad.crt ~/client-configs/keys/
sudo cp ./ta.key ~/client-configs/keys/
sudo cp /etc/openvpn/server/ca.crt ~/client-configs/keys/
sudo chown pugachevvv ~/client-configs/keys/*
sudo cp /usr/share/doc/openvpn/examples/sample-config-files/server.conf.gz /etc/openvpn/server
sudo gunzip /etc/openvpn/server/server.conf.gz
```

## sudo vi /etc/openvpn/server/server.conf
### нужно найти и раскоментировать
```
push "route 10.0.0.0 255.0.0.0"
push "dhcp-option DNS 10.0.0.254"

;tls-auth ta.key 0 # This file is secret
tls-crypt ta.key

cipher AES-256-CBC

;dh dh.pem
dh none

user nobody
group nogroup
cert netology_diplom.crt
key netology_diplom.key  # This file should be kept secret

```
### нужно добавить
```
auth SHA256
```

```
sudo systemctl restart openvpn-server@server.service

systemctl status openvpn-server@server.service
mkdir -p client-configs/files
cp /usr/share/doc/openvpn/examples/sample-config-files/client.conf client-configs/base.conf 
``` 
```
vi client-configs/base.conf
``` 
 ```
 # to load balance between the servers.
remote 51.250.10.114 1194

# Downgrade privileges after initialization (non-Windows only)
user nobody
group nogroup

# file can be used for all clients.
;ca ca.crt
;cert client.crt
;key client.key

# then every client must also have the key.
;tls-auth ta.key 1

# See also the ncp-cipher option in the manpage
cipher AES-256-GCM
auth SHA256
key-direction 1
 ```
```
vi client-configs/make_config.sh
```
```
 #!/bin/bash
 
# First argument: Client identifier
 
KEY_DIR=~/client-configs/keys
OUTPUT_DIR=~/client-configs/files
BASE_CONFIG=~/client-configs/base.conf
 
cat ${BASE_CONFIG} \
    <(echo -e '<ca>') \
    ${KEY_DIR}/ca.crt \
    <(echo -e '</ca>\n<cert>') \
    ${KEY_DIR}/${1}.crt \
    <(echo -e '</cert>\n<key>') \
    ${KEY_DIR}/${1}.key \
    <(echo -e '</key>\n<tls-crypt>') \
    ${KEY_DIR}/ta.key \
    <(echo -e '</tls-crypt>') \
    > ${OUTPUT_DIR}/${1}.ovpn
 ```
```
chmod 700 client-configs/make_config.sh 
./make_config.sh vlad 
```