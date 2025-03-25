#!/bin/sh

read -p "Install for all users? (y/n): " symbolsYN

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

version_number=${latest_version#v}
link="https://github.com/savioruz/nitch/releases/download/${latest_version}/nitch-${version_number}-linux-${arch}.tar.gz"

echo "Installing..."

case $symbolsYN in
  "y")
    dir="/usr/local/bin/nitch"
    use_sudo="sudo"
    ;;
  "n")
    dir="$HOME/.local/bin/nitch"
    use_sudo=""
    if [ ! -d "$HOME/.local/bin" ]; then
      mkdir -p "$HOME/.local/bin"
    fi
    ;;
esac

temp_file=$(mktemp)
wget -q -O $temp_file $link

if file $temp_file | grep -q 'gzip compressed data'; then
  $use_sudo tar -xz -C $(dirname $dir) -f $temp_file
  $use_sudo chmod +x $dir
  echo "Installation complete."
else
  echo "Error: Downloaded file is not a valid gzip archive."
  exit 1
fi

rm $temp_file
