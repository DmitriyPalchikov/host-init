#!/bin/bash
set -euo pipefail

PKG_MANAGERS=("apt" "dnf")
PKG_LIST=("git" "ansible")

PKG_MANAGER_PATH=""
PKG_MANAGER=""

function check_pkg_manager() {
  for i in $1; do
    PKG_MANAGER_PATH=$(which "$i")
    if [[ -z "$PKG_MANAGER_PATH" ]]; then
      PKG_MANAGER=$PKG_MANAGER_PATH;
    fi
  done
}

function install_packages ()
{
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
  
