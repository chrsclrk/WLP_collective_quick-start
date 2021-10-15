#!/usr/bin/env bash
## 

set -o errexit
set -o nounset

lvl01='***'
lvl02='---'
printf "\n${lvl01} %s Show firewalld settings for $HOSTNAME ${lvl01}\n"   $(date --iso-8601=seconds)

# # sudo firewall-cmd --zone=public --permanent --add-port=9080/tcp
# sudo firewall-cmd --zone=public --permanent --add-port=9443/tcp
# # sudo firewall-cmd --zone=public --permanent --add-port=10010/tcp
# sudo firewall-cmd --reload

printf "\n${lvl02} %s firewall-cmd --list-services  ${lvl02}\n"
sudo firewall-cmd --list-services | tr ' ' '\n' | nl

printf "\n${lvl02} %s firewall-cmd --list-ports  ${lvl02}\n"
sudo firewall-cmd --list-ports | tr ' ' '\n' | nl
prts[0]='9080'
prts[1]='9443'
prts[2]='10010'
for idx in ${!prts[@]}
do
    printf '   %+5s -- %s\n' ${prts[$idx]}  "$(sudo firewall-cmd --zone=public --query-port=${prts[$idx]}/tcp)"
done
# sudo firewall-cmd --zone=public --query-port=9443/tcp
# sudo firewall-cmd --zone=public --query-port=10010/tcp