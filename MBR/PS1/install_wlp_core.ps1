#!/usr/bin/env pwsh

##VARIABLES
. PS1/prj61801_common.ps1

$pkgs = @('com.ibm.websphere.liberty.CORE_16.0.2.20160526_2338',
          'com.ibm.websphere.liberty.CORE_21.0.10.20210920_1901',
          'com.ibm.java.jdk.v8_8.0.6036.20210920_0725' )

##FUNCTIONS
function worker {
	[CmdletBinding()]
	param ( $pkg )

    $cmmnd += "$imcl_loc install "
    $cmmnd += "$pkg "
    $cmmnd += "-repositories $wlp_pkgs_http " 
    $cmmnd += "-installationDirectory $wlp_cr_loc "
    # $cmmnd += '-showProgress '
    $cmmnd += '-acceptLicense'
	Write-Host "`n$lvl2  $pkg  $lvl2`n"
    Write-Host $cmmnd
	# Invoke-Expression $cmmnd
}

##MAIN
msg_lvl1('Install IIM packages fetched from ibm.com that provide WLP Core.')

$pkgs.ForEach( { worker  $PSItem } )