#!/bin/bash
set -euo pipefail

PKG_MANAGERS=("apt" "dnf")
PKG_LIST=("git" "ansible")

PKG_MANAGER=""

function check_pkg_manager() {
  arr=("$@")
  for i in "${arr[@]}"; do
    if command -v "$i" >/dev/null 2>&1; then
      PKG_MANAGER=$i
    fi
  done
}

function install_packages () {
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

if [[ -n "$PKG_MANAGER" ]]; then
  install_packages "$PKG_MANAGER"
else
  echo "PKG_MANAGER not defined"
  exit 1
fi
  
