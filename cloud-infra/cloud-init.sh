#!/usr/bin/env bash
set -euo pipefail

USERNAME=infra_ops # Customize the sudo non-root username here

# Create user
if [ -f "/etc/debian_version" ]; then
  # Debian-based distros use the `sudo` group
  useradd --create-home --shell "/bin/bash" --groups sudo "${USERNAME}"
fi
if [ -f "/etc/redhat-release" ]; then
  # RHEL-based distros use the `wheel` group
  useradd --create-home --shell "/bin/bash" --groups wheel "${USERNAME}"
fi

# Create SSH directory for sudo user and move keys over
home_directory="$(eval echo ~${USERNAME})"
mkdir --parents "${home_directory}/.ssh"
cp /root/.ssh/authorized_keys "${home_directory}/.ssh"
chmod 0700 "${home_directory}/.ssh"
chmod 0600 "${home_directory}/.ssh/authorized_keys"
chown --recursive "${USERNAME}":"${USERNAME}" "${home_directory}/.ssh"

# Allow user to have passwordless sudo
echo "" >> /etc/sudoers
echo "${USERNAME} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers


# Disable SSH login with empty password for all users
# Should be obviated by the next step, but still prefer to have both
sed --in-place 's/^PermitEmptyPasswords.*/PermitEmptyPasswords no/g' /etc/ssh/sshd_config

# Disable SSH login with password for all users
sed --in-place 's/^PasswordAuthentication.*/PasswordAuthentication no/g' /etc/ssh/sshd_config

# Disable root SSH login
sed --in-place 's/^PermitRootLogin.*/PermitRootLogin no/g' /etc/ssh/sshd_config


if sshd -t -q; then systemctl restart sshd; fi