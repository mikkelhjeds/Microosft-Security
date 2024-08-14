#needs the SAMAccountName
$user = "mikhje"; 
Disable-ADAccount -Identity "$user" #-whatif can be appended

#check its disabled

if (condition) {
	(Get-ADUser -Identity $user).enabled
}

#renable when you're ready
Enable-ADAccount -Identity "$user" -verbose
