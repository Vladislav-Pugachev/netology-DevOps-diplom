- name: Config NAT
  hosts: all
  vars:
    - ansible_ssh_host_key_checking: false
  gather_facts: false

  tasks:
    - name: Enable Forward
      ansible.posix.sysctl:
        name: net.ipv4.ip_forward
        value: 1
        sysctl_set: yes
        state: present
        reload: yes
      become: yes 
    - name: install iptables
      ansible.builtin.apt:
        name: iptables-persistent
        update_cache: yes
      become: yes 
    - name: configure MASQUERADE
      ansible.builtin.iptables:
        table: nat
        chain: POSTROUTING
        jump: MASQUERADE
      become: yes 
    - name: forward ssh to contol node
      ansible.builtin.iptables:
        table: nat
        chain: PREROUTING
        in_interface: eth0
        destination_port: 2222
        protocol: tcp
        jump: DNAT
        to_destination: ${control_node_private_ip}:22
      become: yes
    - name: forward kube port
      ansible.builtin.iptables:
        table: nat
        chain: PREROUTING
        in_interface: eth0
        destination_port: 6443
        protocol: tcp
        jump: DNAT
        to_destination: ${control_node_private_ip}:6443
      become: yes
    - name: forward webapp
      ansible.builtin.iptables:
        table: nat
        chain: PREROUTING
        in_interface: eth0
        destination_port: 8080
        protocol: tcp
        jump: DNAT
        to_destination: 172.16.0.28:80
      become: yes 