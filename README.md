# learn-ci-cd

Installing Docker on Ubuntu: https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04

Alpine Docker images: https://hub.docker.com/_/alpine/

pull docker postgres image, run exec -it bash

su - post in order to be able to run initdb command
initdb -D /var/lib/postgresql/data/  -U postgres
pg_ctl -D /var/lib/postgresql/data/ start

## Development

#### Installing dev dependencies

In a virtualenv with python >=3.8

```
% poetry install
```

#### Linting the YAML files in this repo:

From the project root directory:

```
% yamllint -d relaxed  .
```

## Setup Process

### 1. Create Kubernetes Cluster on DigitalOcean VMs

Using ansible to create a kubernetes cluster on DigitalOcean VMs: https://www.digitalocean.com/community/tutorials/how-to-create-a-kubernetes-cluster-using-kubeadm-on-ubuntu-18-04

Something was going wrong with the CNI (Flannel) setup suggested there, so I'm going to use a similar Ansible approach but using the [Bootstrapping clusters with kubeadm](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/) guide from the offical Kubernetes docs.
This version uses Calico instead which seems to be the most supported/recommended Pod Network add on for now.

In directory `./ansible/digital-ocean`:

```
% ansible-playbook -i hosts ./k8s-setup/initial.yml
% ansible-playbook -i hosts ./k8s-setup/k8s-dependencies.yml
% ansible-playbook -i hosts ./k8s-setup/master-node.yml
% ansible-playbook -i hosts ./k8s-setup/worker-nodes.yml
```

#### Control the Cluster from a Local Machine

Copy kubernetes administrator kubeconfig from the remote control plane host to your local:

```
% scp ubuntu@<control-plane-host>:home/ubuntu/.kube/config ~/.kube/config
```

Check the status of the cluster from your local:
```
% kubectl cluster-info
% kubectl get nodes
```

https://github.com/containous/traefik-helm-chart
https://docs.traefik.io/getting-started/install-traefik/

helm repo add traefik https://containous.github.io/traefik-helm-chart

helm install traefik traefik/traefik --namespace kube-system

kubectl -n kube-system port-forward $(kubectl -n kube-system get pods --selector "app.kubernetes.io/name=traefik" --output=name) 9000:9000

in order to install postgres: need to create persistent volumes