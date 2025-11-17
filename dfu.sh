#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail


if [ "$(id --user --name)" != root ]
then
  echo 'Please run as root'
  exit 1
fi

dfu-util --reset --alt bootloader --wait 0451:6165 --download tiboot3.bin || true
echo '##########################################################################'
dfu-util --reset --alt tispl.bin --wait 0451:6165 --download tispl.bin || true
echo '##########################################################################'
dfu-util --reset --alt u-boot.img --wait 0451:6165 --download u-boot.img || true
echo '##########################################################################'
