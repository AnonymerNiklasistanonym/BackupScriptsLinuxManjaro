#!/usr/bin/env bash
set -x
# short
sudo smartctl -t short -a /dev/nvme0

# long
# sudo smartctl -t long -a /dev/sdX
