#!/bin/bash
set -euo pipefail

PKG_MANAGERS=("apt" "dnf")
PKG_LIST=("git" "ansible")

PKG_MANAGER=""

function check_pkg_manager() {
  for i in $1; do
    echo "$i"
    if ! which "$i"; then
      echo " $i not in this system"
    else
      PKG_MANAGER=$i
    fi
  done
}

function install_packages () {
  echo "---> $1"
  $1 update -y
  for i in "${PKG_LIST[@]}"; do
    $1 install -y "$i"
  done
}

# Disable repo fedora-cisco-openh264
if [[ -f /etc/yum.repos.d/fedora-cisco-openh264.repo ]]; then
  sed -i 's/enabled=1/enabled=0/g' /etc/yum.repos.d/fedora-cisco-openh264.repo
fi

check_pkg_manager "${PKG_MANAGERS[@]}"

if [[ -z "$PKG_MANAGER" ]]; then
  install_packages "$PKG_MANAGER"
else
  echo "PKG_MANAGER not defined"
  exit 1
fi
  
