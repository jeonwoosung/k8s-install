    virt-install \
    --virt-type=kvm \
    --name centos7 \
    --ram 2048 \
    --vcpus=1 \
    --os-variant=centos7.0 \
    --cdrom=/var/lib/libvirt/boot/CentOS-7-x86_64-Minimal-1708.iso \
    --network=bridge=br0,model=virtio \
    --graphics vnc \
    --disk path=/var/lib/libvirt/images/centos7.qcow2,size=40,bus=virtio,format=qcow2
