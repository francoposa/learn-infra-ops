# learn-ci-cd

Installing Docker on Ubuntu: https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04

Alpine Docker images: https://hub.docker.com/_/alpine/

pull docker postgres image, run exec -it bash

su - post in order to be able to run initdb command
initdb -D /var/lib/postgresql/data/  -U postgres
pg_ctl -D /var/lib/postgresql/data/ start

## Setup Process

### 1. Create Kubernetes Cluster on DigitalOcean VMs

Using ansible to create a kubernetes cluster on DigitalOcean VMs: https://www.digitalocean.com/community/tutorials/how-to-create-a-kubernetes-cluster-using-kubeadm-on-ubuntu-18-04

Something was going wrong with the CNI (Flannel) setup suggested there, so I'm going to use a similar asnsible approach as suggested in the docs but using the (Bootstrapping clusters with kubeadm)[https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/] guide from the offical docs.
This version uses Calico instead which seems to be the most supported/recommended Pod Network add on for now.

In directory `./ansible/dgo-k8s`:

```
% ansible-playbook -i hosts initial.yml
% ansible-playbook -i hosts k8s-dependencies.yml
% ansible-playbook -i hosts master-node.yml
% ansible-playbook -i hosts worker-nodes.yml
```