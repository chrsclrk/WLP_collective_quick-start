#!/usr/bin/env pwsh
## Remove a WLP server from the collective controller.

##VARIABLES
# . is PowerShell's operator to source a file.
. PS1/prj61801_common.ps1
$mbr_nm = 'srvWCR01'
$wlp_bnry = $wlp_cr_loc

$cmmnd  = "$wlp_bnry/bin/collective remove $mbr_nm "
# $cmmnd += "--host=$cll_hst "
# $cmmnd += "--port=9443 "
# $cmmnd += "--user=Alice "
# $cmmnd += "--password=apple "
$cmmnd += "--controller=$wlp_cntrllr "
$cmmnd += "--autoAcceptCertificates"
if($verbose) {
    msg_lvl1("Remove WLP server $mbr_nm at $mbr_hst from the collective controller at host $cll_hst.")
    show_cmmnd($cmmnd)
}
Invoke-Expression -Command $cmmnd 
## Note, the server needs to be stopped for no claims on files by Java process for deletion to complete.
# Remove-Item -Recurse -Force "$wlp_bnry/usr/servers/$mbr_nm"
# show_mssg_log $wlp_bnry/usr/servers/$mbr_nm/logs/messages.log 