#
# Mikkel Hjeds
#

$adusers = Get-AdUser -filter * -Properties * | Select-object Enabled, Name, UserPrincipalName, Description

foreach ($user in $adusers) {

	if ($user.Description -like "*password*") {
		write-output "$user : True"
	}

}
