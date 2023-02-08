- name: Configute NAT in Mikrotik
  hosts: all
  vars:
    - ansible_connection: ansible.netcommon.network_cli
    - ansible_network_os: community.routeros.routeros
    - ansible_user: admin
    - ansible_ssh_pass: 
    - ansible_ssh_host_key_checking: False
  gather_facts: false
  tasks:
  - name: Gather system resources
    community.routeros.command:
      commands:
        - /system identity set name=mikrotik_node_${workspace}
        - /ip firewall nat add action=dst-nat chain=dstnat dst-address=${nat_ext_ip} dst-port=6443 log=yes protocol=tcp to-addresses=${nat_private_ip} to-ports=6443
        - /ip firewall nat add action=dst-nat chain=dstnat dst-address=${nat_ext_ip} dst-port=2222 protocol=tcp to-addresses=${nat_private_ip} to-ports=2222
        - /ip firewall nat add action=dst-nat chain=dstnat dst-address=${nat_private_ip} dst-port=6443 log=yes protocol=tcp to-addresses=${control_node_private_ip} to-ports=6443
        - /ip firewall nat add action=dst-nat chain=dstnat dst-address=${nat_private_ip} dst-port=2222 log=yes protocol=tcp to-addresses=${control_node_private_ip} to-ports=22
        - /ip firewall nat add action=masquerade chain=srcnat
        - /ip service set telnet disabled=yes
        - /ip service set ftp disabled=yes
        - /ip service set www disabled=yes
        - /ip service set api disabled=yes
        - /ip service set api-ssl disabled=yes
        - user add name=vlad password=netology_admin group=full
        - user disable admin
        - /system license renew account=${mikrotik_login} password=${mikrotik_pass} level=p1
      wait_for: result[0] contains mikrotik_node_${workspace}

