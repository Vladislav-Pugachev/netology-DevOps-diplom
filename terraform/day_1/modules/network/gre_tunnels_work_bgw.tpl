network:
  version: 2
  renderer: networkd
  ethernets:
    lo:
      addresses: ["127.0.0.1/8", "::1/128", "${lo}/32"]
    eth0:
      routes:
        - to: ${admin_bgw_external_ip}/32
          via: ${cidrhost(join("/",[node_internal_ip_bgw,24]),1)}
%{ for key,values in remotes~}
        - to: ${values}/32
          via: ${cidrhost(join("/",[node_internal_ip_bgw,24]),1)}
%{ endfor ~}             
  tunnels:
%{ for key,values in remotes~}
    to_${replace(replace(replace(key,format("%s-",workspace),""),format("-%s","node"),""),"-","_")}:
      mode: gre
      local: ${node_internal_ip_bgw}
      remote: ${values}
      addresses:
        - ${cidrhost(addresses_tunnel[key],1)}/30
      routes:
        - to: ${cidrhost(join("/",[values,24]),254)}/32
          via: ${cidrhost(addresses_tunnel[key],2)}
%{ endfor ~}
    to_admin:
      mode: gre
      local: ${node_internal_ip_bgw}
      remote: ${admin_bgw_external_ip}
      addresses:
        - ${cidrhost(subnet_gre_bgw,1)}/30
      routes:
        - to: ${cidrhost(join("/",[admin_bgw_internal_ip,24]),254)}/32
          via: ${cidrhost(subnet_gre_bgw,2)}