Project setup for a Digital Ocean droplet with minikube
# Prerequisites
* terraform>=1.12.0
* kubectl>=1.17.2

# Environment variable requirements:
```
DO_PAT={your DigitalOcean access token}
SSH_PUB_KEY_PATH={your ssh public key path}
SSH_PVT_KEY_PATH={your ssh private key path}
```
These are retrieved from an `env-vars.sh` file in `run-terraform.sh`

# Run minikube manually
* ssh into the droplet and run:
`minikube start --vm-driver none`

# Expose dashboard
* ssh into the droplet and run:
`kubectl proxy --address='0.0.0.0' --disable-filter=true`
`curl http://<droplet-ip>:8001/api/v1/namespaces/kubernetes-dashboard/services/http:kubernetes-dashboard:/proxy/#/overview?namespace=default`
