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
      remote: ${cidrhost(values,253)}
      addresses:
        - ${cidrhost(addresses_tunnel[key],1)}/30
      routes:
        - to: ${cidrhost(values,254)}/32
          via: ${cidrhost(addresses_tunnel[key],2)}
%{ endfor ~}