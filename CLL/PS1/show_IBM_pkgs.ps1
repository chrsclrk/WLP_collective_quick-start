#!/usr/bin/env pwsh
## Install IBM Installation Manager with userinstc.

##VARIABLES
# . is PowerShell's operator to source a file.
. PS1/prj61801_common.ps1
$fpth = "$prjct_dir/ibm_pkgs_$utc_fn.txt" 

$cmmnd  = $pucl_loc
$cmmnd += ' '
$cmmnd += 'listAvailablePackages '
$cmmnd += '-repositories http://www.ibm.com/software/repositorymanager/com.ibm.websphere.liberty.ND '
$cmmnd += "-masterPasswordFile $imutilsc_mst "
$cmmnd += "-secureStorageFile $imutilsc_ssf "

##MAIN
if($verbose) {
    msg_lvl1("Creates a file of available IIM packages to then filter for packages of interest.")
    show_cmmnd($cmmnd)
}
Invoke-Expression -Command "$cmmnd  > $fpth"

##TODO Convert to a fucntion that accept pipeline input.
$cmmnd  = 'Select-String '
$cmmnd += "-Path $fpth "
$cmmnd += "-Pattern '.*java.*2109' "
$cmmnd += '-AllMatches '
$cmmnd += '-Context 0,1'
Invoke-Expression -Command $cmmnd
$cmmnd  = 'Select-String '
$cmmnd += "-Path $fpth "
$cmmnd += "-Pattern '.*ND_.*2109' "
$cmmnd += '-AllMatches '
$cmmnd += '-Context 0,1'
Invoke-Expression -Command $cmmnd
$cmmnd  = 'Select-String '
$cmmnd += "-Path $fpth "
$cmmnd += "-Pattern '.*CORE.*2109' "
$cmmnd += '-AllMatches '
$cmmnd += '-Context 0,1'
Invoke-Expression -Command $cmmnd