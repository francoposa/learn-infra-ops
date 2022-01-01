#!/usr/bin/env bash

# https://serverfault.com/questions/3331/how-do-i-find-out-what-version-of-linux-is-running
# https://unix.stackexchange.com/questions/29981/how-can-i-tell-whether-a-build-is-debian-based
if [ -f "/etc/debian_version" ]; then
  # Debian-based distro
  echo "Debian-based distro"
fi
if [ -f "/etc/redhat-release" ]; then
  # RHEL-based distro
  echo "RHEL-based distro"
fi