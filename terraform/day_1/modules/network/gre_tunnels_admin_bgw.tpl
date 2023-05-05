network:
  version: 2
  renderer: networkd
  ethernets:
    lo:
      addresses: ["127.0.0.1/8", "::1/128", "${lo}/32"]
    eth0:
      routes:
        - to: ${remotes}/32
          via: ${cidrhost(join("/",[local,24]),1)}
  tunnels:
    to_${workspace}_bgw:
      mode: gre
      local: ${local}
      remote: ${remotes}
      addresses:
        - ${cidrhost(subnet_gre_bgw,2)}/30
      routes:
        - to: ${cidrhost(join("/",[node_internal_ip_bgw,24]),254)}/32
          via: ${cidrhost(subnet_gre_bgw,2)}