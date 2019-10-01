add to genie-plugin and weave-net daemonsets:

      tolerations:
      - operator: Exists

(allow them to run on kiam server marked nodes)

add to kiam agent container startup args:

--gateway-timeout-creation=60s


test with aws cli in a debian based container

apt-get update
apt-get -y install python python-pip
pip install awscli
aws s3 ls



helm install ./helm -f ./addon-values-kiam.yaml --namespace kube-system --version 2.5.1 --name "a"