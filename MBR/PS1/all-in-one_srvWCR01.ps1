#!/usr/bin/env pwsh
## Creates WLP server with all tasks in one script.

##VARIABLES
# . is PowerShell's operator to source a file.
. PS1/secrets.ps1
. PS1/prj61801_common.ps1
$mbr_nm = 'srvWCR01'
$wlp_bnry = $wlp_cr_loc
$ErrorActionPreference = 'Stop'

##FUNCTIONS
##MAIN

### server create srv
$cmmnd  = "$wlp_bnry/bin/server create $mbr_nm "
if($verbose) {
	msg_lvl1("Create $mbr_nm to join a WLP Collective as a member.")
	show_cmmnd($cmmnd)
}
Invoke-Expression -Command $cmmnd

$dest = "$wlp_cr_loc/usr/servers/$mbr_nm/bootstrap.properties"
New-Item -Path $dest -ItemType File -Value 'com.ibm.ws.logging.isoDateFormat=true'
$src = "$wlp_cr_loc/usr/servers/$mbr_nm/server.xml"
$cmmnd  = 'cp -p '
$cmmnd += "$src "
$cmmnd += "$src.000"
if($verbose) {
    Write-Host $cmmnd
}
Invoke-Expression -Command $cmmnd
$cmmnd  = 'cp -p '
$cmmnd += "$src "
$cmmnd += "$src.001"
if($verbose) {
    Write-Host $cmmnd
}
Invoke-Expression -Command $cmmnd

### collective join 
$cmmnd  = "$wlp_bnry/bin/collective join $mbr_nm "
$cmmnd += "--controller=$wlp_cntrllr "
$cmmnd += "--keystorePassword=kspw "
$cmmnd += "--autoAcceptCertificates "
$cmmnd += "--createConfigFile=$wlp_cr_loc/usr/servers/$mbr_nm/clltv_mbr.xml"
##MAIN
if($verbose) {
    msg_lvl1("Join WLP server $mbr_srv at $mbr_hst to the collective controller at host $cll_hst.")
    show_cmmnd($cmmnd)
}
Invoke-Expression -Command $cmmnd

### collective updateHost
$cmmnd  = "$wlp_cr_loc/bin/collective updateHost "
$cmmnd += "--controller=$wlp_cntrllr "
$cmmnd += '--autoAcceptCertificates '
$cmmnd += '--hostReadPath=/opt/PRJ61801/WLPCR/usr '
$cmmnd += '--hostWritePath=/opt/PRJ61801/WLPCR/usr '

if($verbose) {
    msg_lvl1("Updates WLP server $mbr_srv at $mbr_hst to the collective controller at host $cll_hst.")
    show_cmmnd($cmmnd)
}
Invoke-Expression -Command $cmmnd

### server.xml modificiations
#### Proxy for a Python program that takes a set of parameters and emits a customized server.xml.'
$cmmnd  = 'cp -p '
$cmmnd += '/home/virtuser/PRJ61801/MBR/server.xml.mbr.001 '
$cmmnd += "$wlp_bnry/usr/servers/$mbr_nm/."
if($verbose) {
    msg_lvl1("Pull a customized server.xml for $mbr_nm.")
    show_cmmnd($cmmnd)
}
Invoke-Expression -Command $cmmnd
$cmmnd  = 'cp -p '
$cmmnd += "$wlp_bnry/usr/servers/$mbr_nm/server.xml.mbr.001 "
$cmmnd += "$wlp_bnry/usr/servers/$mbr_nm/server.xml"
if($verbose) {
    show_cmmnd($cmmnd)
}
Invoke-Expression -Command $cmmnd


### start server
# $cmmnd  = "$wlp_bnry/bin/server start $mbr_nm "
# Invoke-Expression -Command $cmmnd 
# $cmmnd = "$usr_ps1/show_wlp_mssgs.ps1 $wlp_bnry/usr/servers/$mbr_nm/logs/messages.log"
# if($verbose) {
#     msg_lvl1("Start $mbr_nm on $mbr_hst for WLP collective controller $clltv.")
#     show_cmmnd($cmmnd)
# }
& "PS1/start_$mbr_nm.ps1"
# if( $? ) {
#     & "$usr_ps1/show_wlp_mssgs.ps1 $wlp_bnry/usr/servers/$mbr_nm/logs/messages.log" 
# }


### collective testConnection
& PS1/testConnection_srvWCR01.ps1