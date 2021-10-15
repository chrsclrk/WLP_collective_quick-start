#!/usr/bin/env pwsh
param(
	[string]$fpth # file path
)

##VARIABLES
# . is PowerShell's operator for source a file.
. PS1/prj61801_common.ps1

##FUNCTION
function ln_col {
	# Requires server bootstrap.properties file to contan 'com.ibm.ws.logging.isoDateFormat=true'.
	[CmdletBinding()]
	param (
		[Parameter()]
		[string] $ln = 'Hmmm ... not what is expected.'
	)
	if ( $ln.Length -gt 101) {
	    $pttrn = @( $ln.Substring(0,1), $ln.Substring(29,1) ) -join ''
	    if ( $pttrn -eq '[]' ) {
			Write-Host
			Write-Host $ln.Substring(0,101)
			Write-Host $ln.Substring(101)
		}
	}
	else {
		Write-Host "$ln"
	}
}

##MAIN
msg_lvl1("Review $fpth")

# $utc = Get-Date -AsUTC -UFormat '%Y-%m-%dT%H:%M:%S+00:00'
# Write-Host "$lvl1  $utc : $dscrptn  $lvl1`n"

# $dest = @( $wlp_nd_loc, 'usr/servers', $srv_nm, 'logs/messages.log') -join '/'
$lg = Get-Content $fpth

## Initial syntax for iterating across a collection.
# foreach ( $idx in 0..50) {
# 	ln_fmt $lg[$idx]
# }
## Compact syntax for iterating across a collection.
# $lg[0..10].ForEach( { ln_fmt($PSItem) } )
$lg.ForEach( { ln_col($PSItem) } )