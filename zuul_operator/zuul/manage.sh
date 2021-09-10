#!/bin/bash
#
# Manager-Script for testing with single
# node kubernetes clusters. Easy deploy
# and destruction are the main features.
#
#########################################

prepare() {
  cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
br_netfilter
EOF

  cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
  sudo sysctl --system
  sudo apt update
  sudo apt install -y apt-transport-https ca-certificates curl
  sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
  echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
  sudo apt update
  sudo apt install -y kubelet kubeadm kubectl
  sudo apt-mark hold kubelet kubeadm kubectl
  wget https://github.com/derailed/k9s/releases/download/v0.24.14/k9s_Linux_x86_64.tar.gz
  sudo tar xzf "*.tar.gz" --directory /usr/local/bin
  rm "*.tar.gz"
}


deploy() {
  mkdir "${HOME}/.kube"
  sudo kubeadm init --pod-network-cidr=192.168.0.0/16
  sudo cp /etc/kubernetes/admin.conf "${HOME}/.kube/config"
  sudo chown "$(id -u):$(id -g)" "${HOME}/.kube/config"
  kubectl create -f https://docs.projectcalico.org/manifests/tigera-operator.yaml
  kubectl create -f https://docs.projectcalico.org/manifests/custom-resources.yaml
  echo "Standby for network to become ready ..."
  while true; do
    if [[ "$(kubectl get pods --namespace=calico-system --selector='k8s-app=calico-kube-controllers' 2>/dev/null | wc -l)" == "0" ]]; then continue; fi
    if [[ "$(kubectl get pods --namespace=calico-system --selector='k8s-app=calico-node'             2>/dev/null | wc -l)" == "0" ]]; then continue; fi
    if [[ "$(kubectl get pods --namespace=calico-system --selector='k8s-app=calico-typha'            2>/dev/null | wc -l)" == "0" ]]; then continue; fi
    break
  done
  kubectl wait pods --namespace=calico-system --for=condition=Ready --timeout=120s --selector='k8s-app=calico-kube-controllers'
  kubectl wait pods --namespace=calico-system --for=condition=Ready --timeout=120s --selector='k8s-app=calico-node'
  kubectl wait pods --namespace=calico-system --for=condition=Ready --timeout=120s --selector='k8s-app=calico-typha'
  kubectl taint nodes --all node-role.kubernetes.io/master-
}


destroy() {
  sudo kubeadm reset -f
}


reset() {
  destroy
  deploy
}

zuul() {
  git clone https://opendev.org/zuul/zuul-operator.git
  cd zuul-operator || exit
  kubectl apply -f deploy/crds/zuul-ci_v1alpha2_zuul_crd.yaml -f deploy/rbac.yaml -f deploy/operator.yaml
  cd - || exit
}


if test -z "$1"; then
  echo "Select a mode: "
  declare -F | cut -d" " -f 3
else
  $1
fi
