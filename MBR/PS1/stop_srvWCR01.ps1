#!/usr/bin/env pwsh

##VARIABLES
# . is PowerShell's operator to source a file.  Providing commons variables and functions.
. PS1/prj61801_common.ps1
$srv_nm = 'srvWCR01'
$wlp_bnry = $wlp_cr_loc

$cmmnd += "$wlp_bnry/bin/server stop $srv_nm "

##FUNCTIONS
##MAIN

if($verbose) {
    msg_lvl1("Stop $srv_nm on $mbr_hst a WLP collective controller member.")
    show_cmmnd($cmmnd)
}
Invoke-Expression -Command $cmmnd 
show_mssg_log $wlp_bnry/usr/servers/$srv_nm/logs/messages.log 