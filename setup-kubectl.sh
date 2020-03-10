#!/bin/bash

# setup local kubectl to connect to minikube

ssh-keyscan -H $1 >> ~/.ssh/known_hosts
scp root@$1:/root/.kube/config ~/.kube/
scp root@$1:/root/.minikube/client.crt ~/.kube/
scp root@$1:/root/.minikube/client.key ~/.kube/
scp root@$1:/root/.minikube/ca.crt ~/.kube/
sed -iE "s@client-certificate.*client.crt@client-certificate: $HOME/.kube/client.crt@g" ~/.kube/config
sed -iE "s@client-key.*client.key@client-key: $HOME/.kube/client.key@g" ~/.kube/config
sed -iE "s@certificate-authority.*ca.crt@certificate-authority: $HOME/.kube/ca.crt@g" ~/.kube/config
