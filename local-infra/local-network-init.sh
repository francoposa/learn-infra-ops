nmcli connection show
nmcli device show ens18
nmcli connection modify ens18 ipv4.method manual ipv4.addresses 192.168.100.201 ipv4.gateway 192.168.0.1
nmcli connection modify ens18 ipv4.dns 192.168.0.1
nmcli general hostname 201.optiplex-0.local
nmcli connection modify ens18 connection.autoconnect true
nmcli connection up ens18

