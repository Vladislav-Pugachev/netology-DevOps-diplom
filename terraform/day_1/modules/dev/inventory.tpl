all:
  hosts:
    ${control_node_name}:
      ansible_host: ${control_node_private_ip}
      ip: ${control_node_private_ip}
      access_ip: ${control_node_private_ip}
      vars:
        supplementary_addresses_in_ssl_keys: ['${control_node_ext_ip}']
    worker-1:
      ansible_host: 10.10.1.2
      ip: 10.10.1.2
      access_ip: 10.10.1.2
    worker-2:
      ansible_host: 10.10.1.5
      ip: 10.10.1.5
      access_ip: 10.10.1.5
  children:
    kube_control_plane:
      hosts:
        "${control_node_name}":
    kube_node:
      hosts:
        worker-1:
        worker-2:
    etcd:
      hosts:
        "${control_node_name}":
    k8s_cluster:
      children:
        kube_control_plane:
        kube_node:
    calico_rr:
      hosts: {}
