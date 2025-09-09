#!/bin/bash -e

# 设置namespace
kubectl apply -f ./namespace.yaml
# 安装volcano
kubectl apply -f ./volcano-development.yaml

# 生成访问访问etcd的证书
kubectl create secret generic api-cert-secret   --from-file=apiserver-kubelet-client.crt=/etc/kubernetes/pki/apiserver-kubelet-client.crt   --from-file=apiserver-kubelet-client.key=/etc/kubernetes/pki/apiserver-kubelet-client.key   --from-file=ca.crt=/etc/kubernetes/pki/ca.crt -n volcano-monitoring
kubectl create secret generic etcd-cert-secret   --from-file=ca.pem=/etc/ssl/etcd/ssl/ca.pem   --from-file=key.pem=/etc/ssl/etcd/ssl/admin-master-service-key.pem   --from-file=cert.pem=/etc/ssl/etcd/ssl/admin-master-service.pem -n volcano-monitoring

# 配置prometheus的configmap
kubectl apply -f ./prometheus-configmap.yaml
# 安装prometheus
kubectl apply -f ./volcano-monitoring-pvc.yaml
# 安装alertmanager
kubectl apply -f ./alertmanager.yaml

kubectl apply -f ../GPU

kubectl apply -f ../kube-state-metrics
