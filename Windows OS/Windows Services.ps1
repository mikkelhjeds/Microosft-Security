# Get Service by ServiceName
$ServiceName = "eventlog"; 
gwmi -Class Win32_Service -Filter "Name = '$ServiceName' " | fl *

# or this, but you get less information compared to the one about tbh
get-service -name "eventlog" | fl *

Get-Service | Out-GridView

# !Kill Service!
Get-Service -DisplayName "meme_service" | Stop-Service -Force -Confirm:$false -verbose

# Sneaky Services
Get-ItemProperty -Path "HKLM:\System\CurrentControlSet\services\*" | ft PSChildName, ImagePath -autosize | out-string -width 800

Get-ItemProperty -Path "HKLM:\System\CurrentControlSet\services\*" | where ImagePath -notlike "*System32*" | ft PSChildName, ImagePath -autosize | out-string -width 800