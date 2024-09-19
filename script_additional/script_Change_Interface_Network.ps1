#program by frederic meunier
#script for user creation

#view Interface Network
echo "Interface Connected:"
Get-NetAdapter

#Change setting for interface network

#Request User
    #User Interface
$Interface = Read-Host "Interface Name(exemple: Ethernet0)"
    #IP Address
$IP = Read-Host "IP Address (format : 0.0.0.0)"
    #Prefix Length
$Prefix = Read-Host "subnet mask Prefix Length (Format: 24)"
    #Default GateWay
$Gateway = Read-Host "Default Gateway"
    #DNS
$PrimaryDNS = Read-Host "Primary DNS Server"
$SecondDNS  = Read-Host "Second DNS Server"

#Apply Settings
Remove-NetIPAddress -InterfaceAlias $Interface -IPAddress $IP -Confirm:$false
New-NetIPAddress `
-InterfaceAlias $Interface `
-IPAddress $IP `
-PrefixLength $Prefix `
-DefaultGateway $Gateway

#Set DNS
$InterfaceIndex = (Get-NetAdapter -Name $Interface).InterfaceIndex
Set-DnsClientServerAddress -InterfaceIndex $Interface -ServerAddresses ($PrimaryDNS,$SecondDNS)
Pause
