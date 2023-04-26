network:
  version: 2
  renderer: networkd
  ethernets:
    lo:
      addresses: ["127.0.0.1/8", "::1/128", "${lo}/32"]
  tunnels:
    gre-${name}:
      mode: gre
      local: ${local}
      remote: ${remote}
      addresses:
        - ${addresses}/30
      routes:
        - to: ${routes_to}/32
          via: ${routes_via}
        - to: default
          via: ${routes_via}
          metric: 10 