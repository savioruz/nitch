#!/bin/sh

latest_version=$(curl -s https://api.github.com/repos/savioruz/nitch/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')

arch=$(uname -m)
case $arch in
  x86_64)
    arch="amd64"
    ;;
  armv7l)
    arch="arm"
    ;;
  aarch64)
    arch="arm64"
    ;;
  *)
    echo "Unsupported architecture: $arch"
    exit 1
    ;;
esac

link="https://github.com/savioruz/nitch/releases/download/${latest_version}/nitch-${latest_version}-linux-${arch}.tar.gz"

echo ""

read -p "Install for all users? (y/n): " symbolsYN
echo "Installation..."

case $symbolsYN in
  "y")
    dir="/usr/local/bin/nitch"
    ;;
  "n")
    dir="$HOME/.local/bin/nitch"
    if [ ! -d "$HOME/.local/bin" ]; then
      mkdir -p "$HOME/.local/bin"
    fi
    ;;
esac

# Download and extract the binary
wget -q --show-progress -O - $link | tar -xz -C $(dirname $dir)

echo "Installation complete."
