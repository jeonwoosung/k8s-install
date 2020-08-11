# k8s-install

## Docker Install
yum install -y docker
service docker start
chkconfig docker on 

## Iptable설정
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sudo sysctl --system

## OS설정 변경
service firewalld stop # 미적용시 workernode설치 시 masternode api서버 접속(6443 port)불가로 설치 불가
echo "192.168.0.51 masternode" >> /etc/hosts # 미적용시 MasterNode설치 오류 발생
swapoff -a # 미적용시 MasterNode설치 오류 발생
영구 반영 시 /etc/fstab파일의 swap 아래와 같이 수정
[root@masternode ~]# cat /etc/fstab
#
# /etc/fstab
# Created by anaconda on Tue Aug 11 03:59:56 2020
#
# Accessible filesystems, by reference, are maintained under '/dev/disk'
# See man pages fstab(5), findfs(8), mount(8) and/or blkid(8) for more info
#
/dev/mapper/centos-root /                       xfs     defaults        0 0
UUID=058a296e-b6d9-4aca-addb-846a907271f1 /boot                   xfs     defaults        0 0
# /dev/mapper/centos-swap swap                    swap    defaults        0 0


## kubeadm, kubelet, kubectl 설치
cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-\$basearch
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
exclude=kubelet kubeadm kubectl
EOF

\# Set SELinux in permissive mode (effectively disabling it)
sudo setenforce 0
sudo sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

sudo yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes

sudo systemctl enable --now kubelet


## MasterNode 설치(with calico)
kubeadm init --pod-network-cidr=192.167.0.0/16 # 사용할 CIDR입력

## MasterNode 설정파일 os설정(kubectl 사용가능 하도록 설정)
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl create -f https://docs.projectcalico.org/manifests/tigera-operator.yaml
wget https://docs.projectcalico.org/manifests/custom-resources.yaml 
cat custom-resources.yaml  | sed "s/192.168.0.0/192.167.0.0/g" > custom-resource.yaml # 상기 변경된 CIDR로 치환
kubectl create -f custom-resources.yaml

## MasterNode내 Pod생성을 위한 taint제거
kubectl taint nodes --all node-role.kubernetes.io/master-

