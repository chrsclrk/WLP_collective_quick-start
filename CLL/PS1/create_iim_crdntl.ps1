#!/usr/bin/env pwsh
## Install IBM Installation Manager with userinstc.

##VARIABLES
# . is PowerShell's operator to source a file.
. PS1/prj61801_common.ps1
. PS1/secrets.ps1

New-Item -Path $imutilsc_mst -ItemType File -Value $imutilsc_mst

$cmmnd  = $imutilsc_loc
$cmmnd += ' ' 
$cmmnd += 'saveCredential ' 
$cmmnd += '-accessRights nonAdmin ' 
$cmmnd += "-masterPasswordFile $imutilsc_mst "
$cmmnd += "-secureStorageFile $imutilsc_ssf "
$cmmnd += "-userName $onetime_secret_id "
$cmmnd += "-userPassword $onetime_secret_pw "
$cmmnd += '-url http://www.ibm.com/software/repositorymanager/com.ibm.cic.packagingUtility/repository.config '
$cmmnd += '-verbose'
if($verbose) {
    msg_lvl1("Creates the IIM credential files.")
    show_cmmnd($cmmnd)
}
Invoke-Expression -Command $cmmnd