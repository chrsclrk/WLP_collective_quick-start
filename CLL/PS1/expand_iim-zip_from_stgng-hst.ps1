#!/usr/bin/env pwsh
## Pull IIM installer from the staging host in a separate step.
## The following link provides download information:
## https://www.ibm.com/support/pages/installation-manager-and-packaging-utility-download-documents

##VARIABLES
# . is PowerShell's operator to source a file.
. PS1/prj61801_common.ps1

#FUNCTIONS
#MAIN
if ( Test-Path -Path $iim_trgt_dir_xtrct ) {
}
else {
    New-Item -Path $iim_trgt_dir_xtrct -ItemType 'directory'
}
if($verbose) {
    msg_lvl1("Expands IBM Installation Manager .zip.")
}
Expand-Archive -Path "$iim_trgt_dir/$iim_zip" -DestinationPath $iim_trgt_dir_xtrct

$cmmnd  = "chmod --recursive 700 $iim_trgt_dir_xtrct"
Invoke-Expression -Command $cmmnd 

$cmmnd  = "$iim_trgt_dir_xtrct/userinstc  -version"
Invoke-Expression -Command $cmmnd 