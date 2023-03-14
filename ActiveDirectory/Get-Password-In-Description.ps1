#
# Mikkel Hjeds
#

$adusers = Get-AdUser -filter * -Properties * | Select-object Enabled, Name, UserPrincipalName, Description

foreach ($user in $adusers) {

	write-output "$user"

	if ($user.Description -like "regnskab") {
		write-output "True"
	}

}
