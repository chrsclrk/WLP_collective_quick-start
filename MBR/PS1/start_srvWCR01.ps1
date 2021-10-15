#!/usr/bin/env pwsh
## Starts a WLP server.

##VARIABLES
# . is PowerShell's operator to source a file.  Providing commons variables and functions.
. PS1/prj61801_common.ps1
$wlp_bnry = $wlp_cr_loc
$mbr_nm = 'srvWCR01'

$cmmnd  = "$wlp_bnry/bin/server start $mbr_nm "

##FUNCTIONS
##MAIN
if($verbose) {
    msg_lvl1("Start $mbr_nm on $mbr_hst for WLP collective controller $clltv.")
    show_cmmnd($cmmnd)
}
Invoke-Expression -Command $cmmnd 

show_mssg_log("$wlp_bnry/usr/servers/$mbr_nm/logs/messages.log")
# $cmmnd = "$usr_ps1/show_wlp_mssgs.ps1 $wlp_bnry/usr/servers/$srv_nm/logs/messages.log"
# Invoke-Expression -Command $cmmnd 