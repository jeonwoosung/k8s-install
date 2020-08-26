  virt-install --name master \
   --memory 1024 \
   --vcpus 1 \
   --disk size=20 \
   --os-variant rhel7.0 \
   --location /home/osimage/CentOS-7-x86_64-Minimal-2003.iso \
   --graphics none \
   --extra-args='console=ttyS0'
