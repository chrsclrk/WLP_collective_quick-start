#!/usr/bin/env bash
## Creates directories for prj61801.  Tested on RHEL 8.4.  
## Follows Alex Wood's convention of all caps for directory names that I create.

set -o errexit
set -o nounset

drs[0]='/home/virtuser/PRJ61801/CLL/SH'
drs[1]='/home/virtuser/PRJ61801/CLL/PS1'
drs[2]='/opt/PRJ61801/SHBX'

function wrkr {
    mkdir --parents ${1}
    ls -ld ${1}
    printf '\n'

}

printf '\n%s  -- %s -- Creates directories for prj61801. *** \n' '***' "$(date --iso-8601=seconds)"
for idx in ${!drs[@]}
do 
  printf '%s  %s\n' '---' ${drs[idx]}
  wrkr ${drs[idx]}
done