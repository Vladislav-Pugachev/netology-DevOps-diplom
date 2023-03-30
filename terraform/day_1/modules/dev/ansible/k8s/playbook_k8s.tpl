- name: deploy k8s
  hosts: all
  vars:
    - ansible_ssh_host_key_checking: False
    - ansible_ssh_port : 2222
  gather_facts: false

  tasks: 
    - name: install pip python git
      ansible.builtin.apt:
        pkg:
        - git
        - python
        - pip
        update_cache: yes
      become: yes 
    - name: git clone kubespray
      ansible.builtin.git:
        repo: https://github.com/kubernetes-sigs/kubespray.git
        dest: ./kubespray
        version: release-2.21
    - name: install requirements
      ansible.builtin.pip:
        requirements: requirements.txt
        chdir: /home/vlad/kubespray
      become: yes
    - name: copy hosts file to remote
      ansible.builtin.copy:
        src: inventory.yml
        dest: ./kubespray/inventory/sample/hosts.yml
    - name: copy rsa file
      ansible.builtin.copy:
        src: ./ssh/id_rsa
        dest: .ssh/id_rsa
        owner: vlad
        group: v
        mode: '0600'
      become: yes
