#!/bin/bash

mcsmanager_install_path="/opt/mcsmanager"
mcsmanager_download_addr=$(curl -s https://api.github.com/repos/MCSManager/MCSManager/releases/latest | grep -o 'https://.*linux.*\.tar\.gz')
package_name="mcsmanager_linux_release.tar.gz"
node="v20.12.2"
arch=$(uname -m)

if [ "$(id -u)" -ne 0]; then
  echo "This script must be run as root. Please use \"sudo bash\" instead."
  exit 1
fi

printf "\033c"

echo_cyan() {
  printf '\033[1;36m%b\033[0m\n' "$@"
}
echo_red() {
  printf '\033[1;31m%b\033[0m\n' "$@"
}
echo_green() {
  printf '\033[1;32m%b\033[0m\n' "$@"
}
echo_cyan_n() {
  printf '\033[1;36m%b\033[0m' "$@"
}
echo_yellow() {
  printf '\033[1;33m%b\033[0m\n' "$@"
}

# script info
echo_cyan "+----------------------------------------------------------------------
| MCSManager Installer
+----------------------------------------------------------------------
"

Red_Error() {
  echo '================================================='
  printf '\033[1;31;40m%b\033[0m\n' "$@"
  echo '================================================='
  exit 1
}

Update=false
Daemon=false

while [[ $# -gt 0 ]]; do
  key="$1"
  case $key in
    -d)
      Daemon=true
      shift
      ;;
    -u)
      Update=true
      shift
      ;;
    -du|-ud)
      Daemon=true
      Update=true
      shift
      ;;
    *)
      shift
      ;;
  esac
done

Node() {
  if [[ -f "$node_install_path"/bin/node ]] && [[ "$("$node_install_path"/bin/node -v)" == "$node" ]]; then
    echo_green "Node.js version is up-to-date, skipping installation."
    return
  else
    echo_red "Node not find, start to install node.js"
  fi

  echo_cyan_n "[+] Install Node.JS environment...\n"

  rm -irf "$node_install_path"

  cd /opt || Red_Error "[x] Failed to enter /opt"

  rm -rf "node-$node-linux-$arch.tar.gz"

  wget "https://nodejs.org/dist/$node/node-$node-linux-$arch.tar.gz" || Red_Error "[x] Failed to download node release"

  tar -zxf "node-$node-linux-$arch.tar.gz" || Red_Error "[x] Failed to untar node"

  rm -rf "node-$node-linux-$arch.tar.gz"

  if [[ -f "$node_install_path"/bin/node ]] && [[ "$("$node_install_path"/bin/node -v)" == "$node" ]]; then
    echo_green "Success"
  else
    Red_Error "[x] Node installation failed!"
  fi

  echo
  echo_yellow "=============== Node.JS Version ==============="
  echo_yellow " node: $("$node_install_path"/bin/node -v)"
  echo_yellow " npm: v$(env "$node_install_path"/bin/node "$node_install_path"/bin/npm -v)"
  echo_yellow "=============== Node.JS Version ==============="
  echo

  sleep 3
}
