#!/usr/bin/env pwsh

##VARIABLES
# . is PowerShell's operator to source a file.  Providing commons variables and functions.
. PS1/prj61801_common.ps1
$srv_nm = 'srvCLL01'
$wlp_bnry = $wlp_nd_loc

$cmmnd += "$wlp_bnry/bin/server stop $srv_nm "

##FUNCTIONS
##MAIN
msg_lvl1("Stop $srv_nm on $cll_hst for WLP collective controller named $clltv.")

if($verbose) {
    msg_lvl1("Start $srv_nm on $mbr_hst for WLP collective controller $clltv.")
    show_cmmnd($cmmnd)
}
Invoke-Expression -Command $cmmnd 
show_mssg_log $wlp_bnry/usr/servers/$srv_nm/logs/messages.log 