#!/usr/bin/env pwsh
## Installs IBM Installation Manager for the current user with userinstc.

##VARIABLES
# . is PowerShell's operator to source a file.
. PS1/prj61801_common.ps1

$cmmnd  = "$iim_trgt_dir_xtrct/userinstc "
$cmmnd += '-acceptLicense '
$cmmnd += '-accessRights nonAdmin '
$cmmnd += "-dataLocation $usr_hm/IIM_DL "
# $cmmnd += '-showProgress'
if($verbose) {
    msg_lvl1("Installs IBM Installation Manager for the current user with userinstc.")
    show_cmmnd($cmmnd)
}
Invoke-Expression -Command $cmmnd
Invoke-Expression -Command "$imcl_loc version"