#
# Mikkel Hjeds
#

[CmdletBinding()]
param (
	[Parameter(Mandatory = $true)]
	[string]$User
)

Import-Module ActiveDirectory

$domainkoncern = "koncern.local"
$domainfoodit = "foodit.local"
$domainbutik = "butik.local"

function CheckDomains {

	try {
		write "Checking $user in $domainkoncern."
		$koncerndata = Get-ADUser -Server $domainkoncern -Identity $User | select Name, UserPrincipalName, Enabled
	}
	catch {
		write "Could not find user """$user""" in $domainkoncern."
	}

	try {
		write "Checking $user in $domainfoodit"
		$fooditdata = Get-ADUser -Server $domainfoodit -Identity $User | select Name, UserPrincipalName, Enabled
	}
	catch {
		write "Could not find user """$user""" in $domainfoodit."
	}

	try {
		write "Checking $user in $domainbutik"
		$butikdata = Get-ADUser -Server $domainbutik -Identity $User | select Name, UserPrincipalName, Enabled
	}
	catch {
		write "Could not find user """$user""" in $domainbutik."
	}
	
	$returnuser = [PSCustomObject]@{
		koncernName = $koncerndata.Name, $fooditdata.Name, $butikdata.Name
		koncernUpn = $koncerndata.UserPrincipalName, $fooditdata.UserPrincipalName, $butikdata.UserPrincipalName
		koncernEnabled = $koncerndata.Enabled, $fooditdata.Enabled, $butikdata.Name
		# fooditName = $fooditdata.Name
		# fooditUpn = $fooditdata.UserPrincipalName
		# fooditEnabled = $fooditdata.Enabled
		# butikName = $butikdata.Name
		# butikUpn = $butikdata.UserPrincipalName
		# butikEnabled =  $butikdata.Name
	}

	return $returnuser
}

CheckDomains | ft



