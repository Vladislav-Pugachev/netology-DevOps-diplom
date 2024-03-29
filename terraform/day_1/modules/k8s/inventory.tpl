all:
  hosts:
    ${control_node_hostname}:
      ansible_host: ${cidrhost(join("/",[control_node_private_ip,24]),254)}
      ip: ${cidrhost(join("/",[control_node_private_ip,24]),254)}
%{for node in worker_nodes~}
    ${node.hostname}:
      ansible_host: ${cidrhost(join("/",[node.network_interface.0.ip_address,24]),254)}
      ip: ${cidrhost(join("/",[node.network_interface.0.ip_address,24]),254)}
%{ endfor ~}
  children:
    kube_control_plane:
      hosts:
        ${control_node_hostname}:
    kube_node:
      hosts:
%{for node in worker_nodes~}
        ${node.hostname}:
%{ endfor ~}
    etcd:
      hosts:
        ${control_node_hostname}:
    k8s_cluster:
      children:
        kube_control_plane:
        kube_node:
    calico_rr:
      hosts: {}
