#!/usr/bin/env bash
##  Firewalld for minimun set of ports.
##   9080 WLP default port of HTTP
##   9443 WLP default port of HTTPS
##  10010 WLP default port for communication among a cluster of collective controllers

set -o errexit
set -o nounset

lvl01='***'
lvl02='---'
printf "\n${lvl01} %s Configure firewalld for minimal number of open ports.  ${lvl01}\n"   $(date --iso-8601=seconds)

  sudo firewall-cmd --zone=public --permanent --add-port=9443/tcp
# sudo firewall-cmd --zone=public --permanent --add-port=9080/tcp
# sudo firewall-cmd --zone=public --permanent --add-port=10010/tcp
sudo firewall-cmd --reload

SH/show_firewalld_cll.sh