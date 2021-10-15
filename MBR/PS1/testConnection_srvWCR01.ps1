#!/usr/bin/env pwsh
## Reports connectivity between a collective member and a collective controller.

##VARIABLES
# . is PowerShell's operator to source a file.
. PS1/prj61801_common.ps1
$wlp_bnry = $wlp_cr_loc
$srv_nm = 'srvWCR01'

$cmmnd  = "ssh -i $stgng_hst_idnty  $stgng_usr@$stgng_hst 'date --iso-8601=seconds' "
if($verbose) {
    msg_lvl1("Tests conectivity from $mbr_hst at $cll_hst.")
    show_cmmnd($cmmnd)
}
Invoke-Expression -Command $cmmnd

$cmmnd  = "$wlp_bnry/bin/collective testConnection "
$cmmnd += @($mbr_hst, "$wlp_bnry/usr", $srv_nm) -join ','
$cmmnd += " "
$cmmnd += "--controller=$wlp_cntrllr "
$cmmnd += '--autoAcceptCertificates '
if($verbose) {
    show_cmmnd($cmmnd)
}
Invoke-Expression -Command $cmmnd