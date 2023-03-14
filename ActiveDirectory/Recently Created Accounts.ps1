import-module ActiveDirectory;

$When = ((Get-Date).AddDays(-7)).Date;

$RecentlyCreatedUsers = Get-ADUser -Filter {whenCreated -ge $When} -Properties whenCreated | Sort-Object whenCreated -Descending

Write-Output $RecentlyCreatedUsers

"$($RecentlyCreatedUsers.Count) users created recently."