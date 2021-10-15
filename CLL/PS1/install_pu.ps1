#!/usr/bin/env pwsh
## Installs IBM Packaging Utility with Installation Manager imcl.

##VARIABLES
# . is PowerShell's operator to source a file.
. PS1/prj61801_common.ps1


$cmmnd  = "$imcl_loc install "
$cmmnd += 'com.ibm.cic.packagingUtility ' 
$cmmnd += '-repositories http://www.ibm.com/software/repositorymanager/com.ibm.cic.packagingUtility/repository.config '
$cmmnd += '-accessRights nonAdmin '
$cmmnd += "-masterPasswordFile $imutilsc_mst "
$cmmnd += "-secureStorageFile $imutilsc_ssf "
# $cmmnd += '-showProgress '
$cmmnd += '-acceptLicense'
if($verbose) {
    msg_lvl1("Install IBM Packaging Utility with Installation Manager imcl.")
    show_cmmnd($cmmnd)
}
Invoke-Expression -Command $cmmnd