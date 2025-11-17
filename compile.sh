#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail


nom-build -A pkgsCross.armv7l-hf-multiplatform.ubootJ722S-EVM-R5 --out-link result-ubootJ722S-EVM-R5
nom-build -A pkgsCross.aarch64-multiplatform.ubootJ722S-EVM-A53 --out-link result-ubootJ722S-EVM-A53
