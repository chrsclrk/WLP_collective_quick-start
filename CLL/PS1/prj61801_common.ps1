## Variables and functions common to the project.

$ErrorActionPreference = 'Stop'

$cll_hst = 'vmrhcll.prj61801'
$mbr_hst = 'vmrhmbr.prj61801'
$clltv = 'cntrllr01'
$lvl1 = '***'
$lvl2 = '---'
$usr_hm = '/home/virtuser'
$prjct = 'prj61801'  # Project, collection of actions and resources to achieve an organizational purpose.
$prjct_dir = @($usr_hm, '/', $prjct.ToUpper()) -join ''
$stgng_hst = $cll_hst          # staging host
$stgng_usr = 'virtuser'   # staging user
$stgng_hst_idnty = '/home/virtuser/.ssh/prj61801'
$stgng_iim_dir = '/Users/redacted/Downloads/PRJ45242/IIM'
$shbx_dir = @('/opt', '/', $prjct.ToUpper(), '/', 'SHBX') -join ''  # shoebox to hold a variety of content
$usr_ps1 = @($usr_hm, '/', $prjct.ToUpper(), '/', 'CLL', '/', 'PS1') -join ''
$utc = Get-Date -AsUTC -UFormat '%Y-%m-%dT%H:%M:%S+00:00'
$utc_fn = Get-Date -AsUTC -UFormat '%Y-%m-%dT%H%M%S'

$iim_zip = 'agent.installer.linux.gtk.x86_64_1.9.1006.20210614_1906.zip'
$iim_trgt_dir = "$shbx_dir/IBM/IIM_ZIP"
$iim_trgt_dir_xtrct = "$shbx_dir/IBM/IIM_ZIP/XTRCT"
$imcl_loc = "$usr_hm/IBM/InstallationManager/eclipse/tools/imcl"
$imutilsc_loc = "$usr_hm/IBM/InstallationManager/eclipse/tools/imutilsc"
$imutilsc_ssf = "$prjct_dir/iim.secureStorageFile"
$imutilsc_mst = "$prjct_dir/iim.passphrase"
$pucl_loc = "$usr_hm/IBM/PackagingUtility/PUCL"
# $ibm_pkgs = @( $SHBX, 'IBM/PKGS') -join '/'
$wlp_pkgs_fs = "$shbx_dir/WLP_PKGS"
$wlp_pkgs_http = 'http://vmrhcll:8000/repository.config'

$prj_bin_dir = @('/opt/', $prjct.ToUpper()) -join ''
$wlp_bs_loc = @('/opt', '/', $prjct.ToUpper(), '/', 'WLPBS') -join ''  # Base
$wlp_cr_loc = @('/opt', '/', $prjct.ToUpper(), '/', 'WLPCR') -join ''  # Core
$wlp_nd_loc = @('/opt', '/', $prjct.ToUpper(), '/', 'WLPND') -join ''  # Network Deployment
$wlp_key_loc = @($usr_hm, '/', $prjct.ToUpper(), '/', 'wlp_key.xml') -join '' 

## Variables for controlling the flow of messages.
$verbose = $true
$show_msg_lvl1 = $false
$show_cmmnd = $false

##FUNCTIONS
function msg_lvl1 {
	[CmdletBinding()]
	param (
		[Parameter()]
		[string] $msg = 'Hmmm ... not the expected message.'
	)
	Write-Host ''
	Write-Host "$lvl1 $utc --  $msg  $lvl1"
	Write-Host ''
}
function show_cmmnd {
	[CmdletBinding()]
	param (
		[Parameter()]
		[string] $msg = 'Hmmm ... not the expected command.'
	)
	Write-Host ">>>"
	Write-Host -Object "$cmmnd"
	Write-Host '<<<'
}
function show_mssg_log {
	[CmdletBinding()]
	param (
		[Parameter()]
		[string] $fpth = 'Hmmm ... not the expected argument.'
	)

	for ($i = 1; $i -le 100; $i++ )
	{
		Write-Progress -Activity "Wait five seconds before reviewing server messages.log" -Status "$i% Complete:" -PercentComplete $i
		Start-Sleep -Milliseconds 50
	}
	Invoke-Expression -Command "$usr_ps1/show_wlp_mssgs.ps1 $fpth"
}

function show_listening_ports {
	[CmdletBinding()]
	param (
		[ValidateNotNullOrEmpty()]
		[string[]]$msg = 'listening IPv4 ports with processes --  part of the execution context.'
	)
	Write-Host "`n$lvl2  $msg  $lvl2"
	$cmmnd = 'sudo ss --listen --numeric --tcp --process | sort -k6'
	Write-Host "     $cmmnd`n"
	Invoke-Expression -Command $cmmnd
}

function show_pkgs_installed {
	[CmdletBinding()]
	param (
		[ValidateNotNullOrEmpty()]
		[string[]]$msg = 'Show the IIM report listInstalledPackages.'
	)

	$cmmnd  = "$imcl_loc listInstalledPackages "
    $cmmnd += '-long  | nl -ba'
	show_cmmnd($cmmnd)
	Invoke-Expression $cmmnd
}
function show_pkgs_available {
	[CmdletBinding()]
	param (
		[ValidateNotNullOrEmpty()]
		[string[]]$msg = 'Show the IIM report listAvailablePackages.'
	)
	Write-Host "`n$lvl2  $msg  $lvl2"

	$cmmnd  = "$imcl_loc listAvailablePackages "
    $cmmnd += "-repositories $wlp_pkgs_fs "
    $cmmnd += '-features '
    $cmmnd += '-showPlatforms '
    $cmmnd += '-long  | nl -ba'
    show_cmmnd($cmmnd)
	Invoke-Expression $cmmnd
}


function show_firewalld {
	[CmdletBinding()]
	param (
		[ValidateNotNullOrEmpty()]
		[string[]]$msg = 'firewalld configuration --  part of the execution context.'
	)
	Write-Host "`n$lvl2  $msg  $lvl2"
	$cmmnd = "sudo firewall-cmd --list-services | tr ' ' '\n' | nl"
	Write-Host "     $cmmnd`n"
	Invoke-Expression $cmmnd

	$cmmnd = "sudo firewall-cmd --list-ports | tr ' ' '\n' | nl"
	Write-Host "     $cmmnd`n"
	Invoke-Expression $cmmnd
}
