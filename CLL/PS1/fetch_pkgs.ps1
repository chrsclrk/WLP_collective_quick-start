#!/usr/bin/env pwsh

##VARIABLES
# . is PowerShell's operator for source a file.
. PS1/prj61801_common.ps1

$pkgs = @( 
    @('com.ibm.websphere.liberty.CORE_16.0.2.20160526_2338',
      'http://www.ibm.com/software/repositorymanager/com.ibm.websphere.liberty.CORE'),
    @('com.ibm.websphere.liberty.CORE_21.0.10.20210920_1901',
      'http://www.ibm.com/software/repositorymanager/com.ibm.websphere.liberty.CORE'),
    @('com.ibm.websphere.liberty.ND_16.0.2.20160526_2338',
      'http://www.ibm.com/software/repositorymanager/com.ibm.websphere.liberty.ND'),
    @('com.ibm.websphere.liberty.ND_21.0.10.20210920_1901',
      'http://www.ibm.com/software/repositorymanager/com.ibm.websphere.liberty.ND'),
    @('com.ibm.java.jdk.v8_8.0.6036.20210920_0725',
      'http://www.ibm.com/software/repositorymanager/com.ibm.websphere.liberty.ND') )

##FUNCTIONS
function worker {
  [CmdletBinding()]
  param ( $pkg,
          $repo )

    $cmmnd += "$pucl_loc copy "
    $cmmnd += "$pkg "
    $cmmnd += "-repositories $repo " 
    $cmmnd += "-masterPasswordFile $imutilsc_mst "
    $cmmnd += "-secureStorageFile $imutilsc_ssf "
    $cmmnd += '-platform os=linux,arch=x86_64 '
    $cmmnd += "-target $wlp_pkgs_fs "
    $cmmnd += '-acceptLicense'
    Write-Host "`n$lvl2  $pkg  $lvl2`n"
    Write-Host $cmmnd
    Invoke-Expression $cmmnd
}

##MAIN
msg_lvl1('Fetch IIM packages from ibm.com.')

$pkgs.ForEach( { worker  $PSItem[0] $PSItem[1] } )