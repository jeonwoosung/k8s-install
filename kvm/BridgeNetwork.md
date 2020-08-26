
    

Add line:

    # vi /etc/sysconfig/network-scripts/enp3s0
    BRIDGE=br0

Save and close the file in vi. Edit /etc/sysconfig/network-scripts/ifcfg-br0 and add:

    # vi /etc/sysconfig/network-scripts/ifcfg-br0

    DEVICE="br0"
    # I am getting ip from DHCP server #
    BOOTPROTO="dhcp"
    IPV6INIT="yes"
    IPV6_AUTOCONF="yes"
    ONBOOT="yes"
    TYPE="Bridge"
    DELAY="0"
