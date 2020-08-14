# Helm
Helm은 kubernetes 패키지 관리 솔루션

## Helm Install
    curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
    chmod 700 get_helm.sh
    ./get_helm.sh

# Helm Chart
차트는 helm의 패키지 포맷으로, 하나의 애플리케이션을 설치하기 위한 파일들로 구성(https://bcho.tistory.com/1337)

## Helm chart Install
    helm repo add stable https://kubernetes-charts.storage.googleapis.com/
