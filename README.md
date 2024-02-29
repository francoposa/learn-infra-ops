# learn-infra-ops

## Development

#### Installing dev dependencies

```
% poetry install --no-root
```

#### Linting the YAML files in this repo:

From the project root directory, yamllint uses the `.yamllint.yaml` file for configuration:

```
% yamllint .
```

## Cloud Infrastructure

### Deploying K3s on a Digitalocean VM

From the root directory:

```shell
export DO_API_TOKEN=dop_v1_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

# Add the ssh key for the VM to the keychain
ssh-add ~/.ssh/id_ed25519_infra_ops  # ssh key for the DO droplet

# Create a new DigitalOcean VM
ansible-playbook ./infrastructure/ansible/inventory/mgmt/digitalocean-demo-create.yaml

# Run a quick demo do verify ssh access
ansible-playbook -i ./infrastructure/ansible/inventory/sources/ ./infrastructure/ansible/inventory/mgmt/digitalocean-demo-shell-example.yaml

# Install k3s on the single VM
ansible-playbook -i ./infrastructure/ansible/inventory/sources/digitalocean.yaml ./infrastructure/ansible/k3s/install.yaml

# Copy the kubeconfig for the cluster to local; merge with existing kubeconfigs
ansible-playbook -i ./infrastructure/ansible/inventory/sources/ ./infrastructure/ansible/k3s/local-kube-config.yaml

# verify connectivity to k3s cluster
kubectl cluster-info
kubectl get nodes
```