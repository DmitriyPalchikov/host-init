#!/bin/bash
set -euo pipefail

PKG_MANAGER=""

PKG_LIST=("git" "ansible")

function install_packages ()
{
  PKG_MANAGER_PATH=$(which $1)
  
  $PKG_MANAGER_PATH update -y
  
  for i in "${PKG_LIST[@]}"; do
    $PKG_MANAGER_PATH install -y $i
  done
}


if [[ -f /etc/redhat-release ]]; then
  PKG_MANAGER="dnf";
  install_packages $PKG_MANAGER
elif [[ -f /etc/debian_version ]]; then
  PKG_MANAGER="apt";
  install_packages $PKG_MANAGER
else
  echo "PKG_MANAGER not defined"
  exit 1
  
