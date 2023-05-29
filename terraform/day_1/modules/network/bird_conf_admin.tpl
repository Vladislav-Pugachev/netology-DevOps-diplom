router id ${lo_admin};

filter export_to_bgp {
        if net= 0.0.0.0/0 then {
        accept;
        }

        reject;
}

protocol kernel {
        learn;
        scan time 60;
        import all;
       export all;
}

protocol device {
        scan time 60;
}

protocol direct {
        interface "*";
}

include "bgp.to_prod_bgw.conf";
include "bgp.to_dev_bgw.conf"; 