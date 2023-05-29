network:
  version: 2
  renderer: networkd
  ethernets:
    lo:
      addresses: ["127.0.0.1/8", "::1/128", "${lo}/32"]
    eth0:
      routes:
        - to: ${remote}/32
          via: ${local_gw}  
  tunnels:
    to_bgw:
      mode: gre
      local: ${local}
      remote: ${remote}
      addresses:
        - ${addresses}/30
      routes:
        - to: default
          via: ${routes_via}
          from: ${lo}
          metric: 10
          on-link: true       
        - to: ${routes_to}/32
          via: ${routes_via}
