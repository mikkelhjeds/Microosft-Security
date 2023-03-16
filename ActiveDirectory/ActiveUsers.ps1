#
# Mikkel Hjeds
#

Import-Module ActiveDirectory

$inactiveusers = @()

$blockedusers = Get-AdUser -filter * -Properties * | select UserPrincipalName, SamAccountName, Enabled, WhenCreated, LastLogonDate, CreateTimeStamp, ModifyTimeStamp
$currentdate = Get-Date

foreach ($user in $blockedusers) {

    if ($user.WhenCreated) {
        $diffwhencreated = (New-TimeSpan -Start $user.WhenCreated -End $currentdate)
    }
    else {
        $diffwhencreated = "-"
    }
    if ($user.LastLogonDate) {
        $difflastlogondate = (New-TimeSpan -Start $user.LastLogonDate -End $currentdate)
    }
    else {
        $difflastlogondate = "-"
    }
    if ($user.CreateTimeStamp) {
        $diffcreatetimestamp = (New-TimeSpan -Start $user.CreateTimeStamp -End $currentdate)
    }
    else {
        $diffcreatetimestamp = "-"
    }
    if ($user.ModifyTimeStamp) {
        $diffmodifytimestamp = (New-TimeSpan -Start $user.ModifyTimeStamp -End $currentdate)
    }
    else {
        $diffmodifytimestamp = "-"
    }

    # $diffwhencreated = (New-TimeSpan -Start $user.WhenCreated -End $currentdate)
    # $difflastlogondate = (New-TimeSpan -Start $user.LastLogonDate -End $currentdate)
    # $diffcreatetimestamp = (New-TimeSpan -Start $user.CreateTimeStamp -End $currentdate)
    # $diffmodifytimestamp = (New-TimeSpan -Start $user.ModifyTimeStamp -End $currentdate)

    $inactiveusers += [PSCustomObject]@{
        upn = $user.UserPrincipalName
        sam = $user.SamAccountName
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

$inactiveusers | Export-Csv -Path ("C:\Temp\ActiveUsers-" + (Get-Date -Format "dd-MM-yyyy-HH_mm") + ".csv") -Delimiter ";" -NoTypeInformation
