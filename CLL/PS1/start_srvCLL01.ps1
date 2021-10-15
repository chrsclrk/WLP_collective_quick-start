#!/usr/bin/env pwsh
## Runs WLP "server start srvCLL01".

##VARIABLES
# . is PowerShell's operator to source a file.  Providing commons variables and functions.
. PS1/prj61801_common.ps1
$wlp_bnry = $wlp_nd_loc
$srv_nm = 'srvCLL01'

$cmmnd += "$wlp_bnry/bin/server start $srv_nm "

##FUNCTIONS
##MAIN
if($verbose) {
    msg_lvl1("Runs WLP `"server start $srv_nm`" on $cll_hst to provide a collective controller.")
    show_cmmnd($cmmnd)
}
Invoke-Expression -Command $cmmnd 
show_mssg_log $wlp_bnry/usr/servers/$srv_nm/logs/messages.log 