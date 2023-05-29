router id ${cidrhost(join("/",[node_internal_ip_bgw,24]),254)};

filter export_to_kernel {
        if net= 0.0.0.0/0 then {
        accept;
        }

       
        reject;
}

filter import_from_bgp {
        if net= 0.0.0.0/0 then {
        accept;
        }
        reject;
}
filter export_to_bgp {
        if net~ ${prefix_list} then {
        accept;
        }

        reject;
}
protocol kernel {
        learn;
        metric 10;
        scan time 60;
        import all;
        export filter export_to_kernel;
}


protocol device {
        scan time 60;
}

protocol direct {
        interface "*";
}

protocol bgp to_admin {
        local as ${as_bgw};
        multihop;
        neighbor  ${lo_admin} as 65000;
        source address ${cidrhost(join("/",[node_internal_ip_bgw,24]),254)};
        export filter export_to_bgp;
}

%{ for key,values in remotes~}
%{if key!= format("%s-control-node",workspace)}
protocol bgp to_${key} {
        local as ${as_bgw};
        multihop;
        neighbor  ${cidrhost(join("/",[values,24]),254)} as ${as_bgw};
        source address ${cidrhost(join("/",[node_internal_ip_bgw,24]),254)};
        rr client;
}
%{ endif }
%{ endfor }