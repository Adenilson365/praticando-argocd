#!/bin/bash

gcloud container clusters get-credentials devops-labs01 \
    --region=us-east1

kubectl create clusterrolebinding cluster-admin-binding \
  --clusterrole cluster-admin \
  --user $(gcloud config get-value account)

#Intalação do prom-grafana para avaliar consumo de recursos do argo
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install prometheus prometheus-community/kube-prometheus-stack --version 67.5.0 --namespace obs -f ./obs/prom-values.yaml --wait

helm repo add argo https://argoproj.github.io/argo-helm
helm repo update
helm install my-argo-cd argo/argo-cd --version 7.8.7 -n argocd --create-namespace --values values.yml

kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d > argo-pass.pass
