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
       export all;   # Actually insert routes into the kernel routing table
}

protocol device {
        scan time 60;
}

protocol direct {
        interface "*";
}