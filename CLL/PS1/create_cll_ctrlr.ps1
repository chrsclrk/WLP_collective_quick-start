#!/usr/bin/env pwsh
## Runs WLP ND "collective create srvCLL01" to provide a collective controller

##VARIABLES
. PS1/prj61801_common.ps1
$clltv = 'cntrllr01'
$srv_nm = 'srvCLL01'
$wlp_bnry = $wlp_nd_loc

$cmmnd  = "$wlp_nd_loc/bin/collective create $srv_nm "
$cmmnd += "--keystorePassword=kspw "
$cmmnd += "--collectiveName=$clltv "
$cmmnd += "--createConfigFile=$wlp_bnry/usr/servers/$srv_nm/$clltv.xml"

##FUNCTIONS
##MAIN
if($verbose) {
	msg_lvl1("Runs WLP ND `"collective create $srv_nm`" to provide a collective controller.")
	show_cmmnd($cmmnd)
}
Invoke-Expression -Command $cmmnd