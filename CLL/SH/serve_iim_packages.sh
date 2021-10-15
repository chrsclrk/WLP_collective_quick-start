#!/usr/bin/env bash
##  Serves IIM packages with Python3.

set -o errexit
set -o nounset

lvl01='***'
lvl02='---'
printf "\n${lvl01} %s Serves IIM packages with Python3..  ${lvl01}\n"   $(date --iso-8601=seconds)

sudo firewall-cmd --add-port=8000/tcp --timeout 30m  && sudo firewall-cmd --list-ports
cd /opt/PRJ61801/SHBX/WLP_PKGS  
python3 -m http.server