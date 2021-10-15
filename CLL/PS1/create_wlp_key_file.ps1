#!/usr/bin/env pwsh
## Creates a file containing a key for WLP encyrption.
## See “PowerShell Cookbook”, 4th Edition, Lee Holmes, June 2021 O’Reilly
##   10.4 "Modify Data in an XML File"

##VARIABLES
# . is PowerShell's operator to source a file.
. PS1/prj61801_common.ps1
. PS1/secrets.ps1
$cmmnd  = "chmod 600 $wlp_key_loc" 

##FUNCTIONS
##MAIN
$strng  = '<server> <variable name="wlp.password.encryption.key" value="yourKey" /> </server>'
$xml = [xml]$strng
$xml.server.variable.value = $onetime_wlp_key
$xml.Save($wlp_key_loc)

if($verbose) {
	msg_lvl1("Creates the file $wlp_key_loc containing a key for WLP encyrption.")
	show_cmmnd($cmmnd)
}
Invoke-Expression $cmmnd