#!/usr/bin/env pwsh
## Reports the WLP ND configuraiton.

##VARIABLES
# . is PowerShell's operator to source a file.
. PS1/prj61801_common.ps1
$wlp_bnry = $wlp_nd_loc
$ErrorActionPreference = 'Stop'

##FUNCTIONS
##MAIN
msg_lvl1 "Show WLP configuration reports for $wlp_bnry."

$cmmnd = "$wlp_bnry/bin/productInfo version --verbose"
Write-Host "$lvl2  $cmmnd  $lvl2`n"
Invoke-Expression $cmmnd

$cmmnd = "$wlp_bnry/java/8.0/bin/java -version"
Write-Host "`n$lvl2  $cmmnd  $lvl2`n"
Invoke-Expression $cmmnd

$fn = "$wlp_bnry/java/java.env"
Write-Host "`n$lvl2  Get-Content -Path $fn  $lvl2`n"
Get-Content -Path $fn