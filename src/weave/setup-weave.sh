#!/usr/bin/env bash

daemonsets_array=($(kubectl -n=kube-system get daemonsets --no-headers=true -o custom-columns=:metadata.name))

if [[ " ${daemonsets_array[@]} " =~ " aws-node " ]]; then
    echo 'found the aws-node daemonset, deleting it...'
    kubectl -n=kube-system delete daemonset "aws-node"
fi

echo 'Applying CNI genie manifest...'
kubectl apply -f ./genie-plugin.yaml

echo 'Applying weave manifest...'
kubectl apply -f ./weave-cni.yaml

echo 'Applying overlay network test pods and services...'
kubectl apply -f ./test-overlay-services-and-deployments.yaml

echo 'Complete. If there were changes to the weave configuration via the manifest, then you should rotate/replace current cluster worker nodes.'
