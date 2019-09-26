#!/usr/bin/env bash

while [[ $(kubectl get pods -l app=hello-node1 -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}') != "True" ]]; do echo "waiting for hello-node1 pod to start..." && sleep 1; done
while [[ $(kubectl get pods -l app=hello-node2 -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}') != "True" ]]; do echo "waiting for hello-node2 pod to start..." && sleep 1; done

echo 'Testing services across from each test deployment pod...'
kubectl exec $(kubectl get pods --no-headers=true -o custom-columns=:metadata.name | grep 'hello-node1') -- sh -c "curl -s -i http://hello-node2:8082"
kubectl exec $(kubectl get pods --no-headers=true -o custom-columns=:metadata.name | grep 'hello-node2') -- sh -c "curl -s -i http://hello-node1:8081"