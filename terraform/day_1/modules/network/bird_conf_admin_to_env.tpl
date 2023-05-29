protocol bgp to_${workspace} {
        local as 65000;
        multihop;
        neighbor  ${cidrhost(join("/",[node_internal_ip_bgw,24]),254)} as ${as_bgw};
        source address ${lo_admin};
        export filter export_to_bgp;
}