network:
  version: 2
  renderer: networkd
  ethernets:
    lo:
      addresses: ["127.0.0.1/8", "::1/128", "${lo}/32"]
  tunnels:
%{ for key,values in remotes~}
    gre-to-${key}:
      mode: gre
      local: ${local}
      remote: ${values}
      addresses:
        - ${cidrhost(addresses_tunnel[key],1)}/30
      routes:
        - to: ${cidrhost(join("/",[values,24]),254)}/32
          via: ${cidrhost(addresses_tunnel[key],2)}
%{ endfor ~}