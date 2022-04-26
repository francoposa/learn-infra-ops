# learn-infra-ops

## Development

#### Installing dev dependencies

In a virtualenv with python >=3.8

```
% poetry install
```

#### Linting the YAML files in this repo:

From the project root directory, yamllint uses the `.yamllint.yaml` file for configuration:

```
% yamllint .
```

## Cloud Infrastructure

### Deploying K3s on a Digitalocean VM

In the `cloud-infra` directory:

```shell
% export DO_API_TOKEN=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

# Create a new DigitalOcean VM
% ansible-playbook ansible/inventory/mgmt/digitalocean-demo-create.yaml

# Add the ssh key for the VM to the keychain
% ssh-add ~/.ssh/id_ed25519_infra_ops  # ssh key for the DO droplet

# Install k3s on the single VM
% ansible-playbook -i ./ansible/inventory/sources/digitalocean.yaml ansible/k3s/install.yaml

# Copy the kubeconfig for the cluster to local; merge with existing kubeconfigs
% ansible-playbook -i ./ansible/inventory/sources/ ansible/k3s/local-kubectl-config.yaml

# verify connectivity to k3s cluster
% kubectl get nodes
```