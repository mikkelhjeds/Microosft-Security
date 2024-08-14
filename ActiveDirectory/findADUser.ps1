#
# Mikkel Hjeds
#

[CmdletBinding()]
param (
	[Parameter(Mandatory = $true)]
	[string]$Username
)

Import-Module ActiveDirectory

$domains = @("koncern.local", "foodit.local", "butik.local")

function CheckDomains {

	foreach ($domain in $domains) {
		$user = Get-ADUser -Server $domain -Identity $Username -Properties * | select Name, UserPrincipalName, Enabled, LastLogonDate, WhenCreated
	

	$returnuser = [PSCustomObject]@{
		Domain        = $Domain
		Name          = $user.Name
		UPN           = $user.UserPrincipalName
		Enabled       = $user.Enabled
		LastLogonDate = $user.LastLogonDate
		Created       = $user.WhenCreated
	}

	return $returnuser
}
}

CheckDomains

