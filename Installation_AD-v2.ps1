#program by Frederic Meunier
#for installation of AD and DNS services

#Valeur entrer utlisateur
    #DNS Delegation
$CreateDnsDelegation = $false
    #Domain Name
$domainName = Read-Host "Domain Name"
    #Name NetBois
$netbiosname = Read-Host "Name netbios"
    #Patch of NT Directory Services (NTDS)
$NTDSPath = Read-Host "Path NTDS or Defaults"
if ($NTDSPath -eq $null) {
    $NTDSPath = "C:\Windows\NTDS"
} else {
    Write-Output $NTDSPath
}
    #Patch Log
$LogPath = Read-Host "C:\Windows\NTDS"
if ($LogPath -eq $null) {
    $LogPath = "C:\Windows\NTDS"
} else {
    Write-Output $LogPath
}
    #Sysvol Patch
$SysvolPath = Read-Host "Sysvol Path"
if ($SysvolPath -eq $null) {
    $SysvolPath = "C:\Windows\SYSVOL"
} else {
    Write-Output $SysvolPath
}
    #Mode du domaine
$DomainMode = Read-Host "Domain mode"
if ($DomainMode -eq $null) {
    $DomainMode = "Default"
} else {
    Write-Output $DomainMode
}
    #Installation DNS
$InstallDNS = $true
    #Mode of forest
$ForestMode = Read-Host "Forest Mode"
if ($ForestMode -eq $null) {
    $ForestMode = "Default"
} else {
    Write-Output $ForestMode
}
    #password admin security
$SafeModeClearPassword = Read-Host "Safe Mode Clear Password"
$SafeModeAdministratorPassword = ConvertTo-SecureString $SafeModeClearPassword -AsPlaintext -Force

#Installation De L'AD
Add-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools -IncludeAllSubFeature

#Installation de DNS
Add-WindowsFeature -Name DNS -IncludeManagementTools -IncludeAllSubFeature

Add-WindowsFeature -Name RSAT-AD-Tools -IncludeManagementTools -IncludeAllSubFeature

#creation delegation
Install-ADDSForest `
-CreateDnsDelegation $CreateDnsDelegation `
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

#restart server
Restart-Computer