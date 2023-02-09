#!/bin/bash
set -e
xargs -0 -L1 -a /proc/1/environ >>/tmp/env.sh
cat /tmp/env.sh
source /tmp/env.sh
socat -d -d TCP-LISTEN:2049,reuseaddr,fork TCP:${EXTERNAL_IP}:2049