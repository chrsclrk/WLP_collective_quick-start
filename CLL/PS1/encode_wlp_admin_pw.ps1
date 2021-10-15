#!/usr/bin/env pwsh
## Encodes a password for server.xml to provide the WLP Admin password.

##VARIABLES
. PS1/prj61801_common.ps1
$wlp_bnry = $wlp_nd_loc

$fn = (Get-Item $wlp_key_loc).FullName
$kyfl = [xml] (Get-Content $fn)
$ky = $kyfl.server.variable.value
$cmmnd  = "$wlp_bnry/bin/securityUtility  encode --encoding=aes --key=$ky"

##FUNCTIONS
##MAIN
if($verbose) {
	msg_lvl1('Encodes a password for server.xml to provide the WLP Admin password.')
	show_cmmnd($cmmnd)
}
Invoke-Expression -Command $cmmnd