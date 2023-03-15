#
# Mikkel Hjeds
#

Import-Module ActiveDirectory

$inactiveusers = @()

$blockedusers = Get-AdUser -filter * -Properties * | select UserPrincipalName, Enabled, WhenCreated, LastLogonDate, CreateTimeStamp, ModifyTimeStamp
$currentdate = Get-Date

foreach ($user in $blockedusers) {

    if ($user.WhenCreated) {
        $diffwhencreated = (New-TimeSpan -Start $user.WhenCreated -End $currentdate)
    }
    if ($user.LastLogonDate) {
        $difflastlogondate = (New-TimeSpan -Start $user.LastLogonDate -End $currentdate)
    }
    if ($user.CreateTimeStamp) {
        $diffcreatetimestamp = (New-TimeSpan -Start $user.CreateTimeStamp -End $currentdate)
    }
    if ($user.ModifyTimeStamp) {
        $diffmodifytimestamp = (New-TimeSpan -Start $user.ModifyTimeStamp -End $currentdate)
    }

    # $diffwhencreated = (New-TimeSpan -Start $user.WhenCreated -End $currentdate)
    # $difflastlogondate = (New-TimeSpan -Start $user.LastLogonDate -End $currentdate)
    # $diffcreatetimestamp = (New-TimeSpan -Start $user.CreateTimeStamp -End $currentdate)
    # $diffmodifytimestamp = (New-TimeSpan -Start $user.ModifyTimeStamp -End $currentdate)

    $inactiveusers += [PSCustomObject]@{
        email = $user.UserPrincipalName
        userenabled = $user.Enabled
        whencreated = $user.WhenCreated
        lastlogondate = $user.LastLogonDate
        createtimestamp = $user.CreateTimeStamp
        dayssincecreated = $diffwhencreated.Days
        dayssincelastlogondate = $difflastlogondate.Days
        dayssincecreatetimestamp = $diffcreatetimestamp.Days
        dayssincemodifytimestamp = $diffmodifytimestamp.Days
    }

}

$inactiveusers | Export-Csv -Path ("C:\Temp\ActiveUsers" + (Get-Date -Format "dddd/MM/ss/yyyy-HH_mm") + ".csv") -Delimiter ";" -NoTypeInformation
