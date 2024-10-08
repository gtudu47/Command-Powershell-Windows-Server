#program by Frederic Meunier and Sebastien Valbuzzi
#for installation of AD and DNS services

# Question for Rename Server
$RNewName = Read-Host "Do you want to change the server name (yes or No)"
if ($RNewName -eq "yes" -or $RNewName -eq "Yes" -or $RNewName -eq "y" -or $RNewName -eq "Y") {
    # Rename Server
    $NewName = Read-Host "New Name for server"
    Rename-Computer -NewName $NewName
    Write-Host "The computer will be renamed to $NewName after restart."
    Restart-Computer
}

# Values enter utilisateur
# DNS Delegation
$CreateDnsDelegation = $false
# Domain Name
$domainName = Read-Host "Domain Name"
# Name NetBios
$netbiosname = Read-Host "Name netbios"
# Path of NT Directory Services (NTDS)
$NTDSPath = Read-Host "Path NTDS or press Enter for Default"
if ([string]::IsNullOrWhiteSpace($NTDSPath)) {
    $NTDSPath = "C:\Windows\NTDS"
}
Write-Output "NTDS Path: $NTDSPath"

# Path Log
$LogPath = Read-Host "Logs Path or press Enter for Default"
if ([string]::IsNullOrWhiteSpace($LogPath)) {
    $LogPath = "C:\Windows\NTDS"
}
Write-Output "Log Path: $LogPath"

# Sysvol Path
$SysvolPath = Read-Host "Sysvol Path or press Enter for Default"
if ([string]::IsNullOrWhiteSpace($SysvolPath)) {
    $SysvolPath = "C:\Windows\SYSVOL"
}
Write-Output "Sysvol Path: $SysvolPath"

# Domain mode
$DomainMode = Read-Host "Domain mode or press Enter for Default"
if ([string]::IsNullOrWhiteSpace($DomainMode)) {
    $DomainMode = "Default"
}
Write-Output "Domain Mode: $DomainMode"

# Installation DNS
$InstallDNS = $true

# Mode of forest
$ForestMode = Read-Host "Forest Mode or press Enter for Default"
if ([string]::IsNullOrWhiteSpace($ForestMode)) {
    $ForestMode = "Default"
}
Write-Output "Forest Mode: $ForestMode"

# Password admin security
$SafeModeClearPassword = Read-Host "Safe Mode Clear Password" -AsSecureString
$SafeModeAdministratorPassword = $SafeModeClearPassword

# Installation De L'AD
Add-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools -IncludeAllSubFeature

# Installation de DNS
Add-WindowsFeature -Name DNS -IncludeManagementTools -IncludeAllSubFeature
Add-WindowsFeature -Name RSAT-AD-Tools -IncludeManagementTools -IncludeAllSubFeature

# Creation delegation
Import-Module ADDSDeployment
Install-ADDSForest `
    -CreateDnsDelegation:$CreateDnsDelegation `
    -DomainName $DomainName `
    -DatabasePath $NTDSPath `
    -DomainMode $DomainMode `
    -DomainNetbiosName $NetbiosName `
    -ForestMode $ForestMode `
    -InstallDNS:$InstallDNS `
    -LogPath $LogPath `
    -NoRebootOnCompletion:$false `
    -SysvolPath $SysvolPath `
    -SafeModeAdministratorPassword $SafeModeAdministratorPassword `
    -Force:$true

Pause
Restart-Computer