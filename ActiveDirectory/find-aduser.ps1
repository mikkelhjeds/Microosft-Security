#
# Mikkel Hjeds
#

[CmdletBinding()]
param (
	[Parameter(Mandatory = $true)]
	[string]$User
)

Import-Module ActiveDirectory

$domains = @("koncern.local", "foodit.local", "butik.local")

function CheckDomains {
	
	try {
		$user = Get-ADUser -Server $domain -Identity $User
	}
	catch {
	}
	

	$returnuser = [PSCustomObject]@{
		Domain  = $Domain
		Name    = $user.Name
		UPN     = $user.UserPrincipalName
		Enabled = $user.Enabled
	}

	return $returnuser
}

foreach ($domain in $domains) {
	
	CheckDomains

}
