#!/usr/bin/env pwsh
## Runs WLP ND "create server srvCLL01" as pre-req for a collective controller.

##VARIABLES
# . is PowerShell's operator to source a file.
. PS1/prj61801_common.ps1
$srv_nm = 'srvCLL01'
$wlp_bnry = $wlp_nd_loc

$cmmnd  = "$wlp_nd_loc/bin/server create $srv_nm"

##FUNCTIONS
##MAIN
if($verbose) {
	msg_lvl1("Runs WLP ND `"create server $srv_nm`" to provide a collective controller pre-req.")
	show_cmmnd($cmmnd)
}
Invoke-Expression -Command $cmmnd

$dest = @( $wlp_nd_loc, 'usr/servers', $srv_nm, 'bootstrap.properties') -join '/'
New-Item -Path $dest -ItemType File -Value 'com.ibm.ws.logging.isoDateFormat=true'

$dest = @( $wlp_nd_loc, 'usr/servers', $srv_nm, 'server.xml') -join '/'
$trgt = @( $dest, '.000') -join ''
$cmmnd  = 'cp -p '
$cmmnd += "$dest "
$cmmnd += $trgt
if($verbose) {
	show_cmmnd($cmmnd)
}
Invoke-Expression -Command $cmmnd
$dest = @( $wlp_nd_loc, 'usr/servers', $srv_nm, 'server.xml') -join '/'
$trgt = @( $dest, '.001') -join ''
$cmmnd  = 'cp -p '
$cmmnd += "$dest "
$cmmnd += $trgt
if($verbose) {
	show_cmmnd($cmmnd)
}
Invoke-Expression -Command $cmmnd