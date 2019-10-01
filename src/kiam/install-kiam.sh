#!/usr/bin/env bash

# echo "installing helm tiller..."
# kubectl --namespace kube-system create serviceaccount tiller
# kubectl create clusterrolebinding tiller --clusterrole cluster-admin --serviceaccount=kube-system:tiller
# helm init --service-account tiller --wait
# sleep 10

echo "annotating 'kube-system' namespace to allow add-ons to assume roles..."
kubectl annotate --overwrite namespace kube-system "iam.amazonaws.com/permitted=.*"

# echo "installing cluster addons using helmsman..."
# helmsman -no-fancy -apply -f helmsman.yaml -verbose -no-ns

# echo "creating extra service monitors for prometheus..."
# kubectl apply -f servicemonitors.yaml

echo "installing helm tiller..."
kubectl --namespace kube-system create serviceaccount tiller
kubectl create clusterrolebinding tiller --clusterrole cluster-admin --serviceaccount=kube-system:tiller
helm init --service-account tiller --wait
sleep 10

helm repo add uswitch https://uswitch.github.io/kiam-helm-charts/charts/
helm repo update
helm install uswitch/kiam -f ./addon-values-kiam.yaml --namespace kube-system --version 2.5.1