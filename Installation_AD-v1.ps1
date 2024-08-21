#program by Frederic Meunier
#for installation of AD and DNS services

#Valeur entrer utlisateur
    #DNS Delegation
$CreateDnsDelegation = $false
    #Domain Name
$domainName = Read-Host "Domain Name:"
    #Name NetBois
$netbiosname = Read-Host "Name netbios:"
    #Patch of NT Directory Services (NTDS)
$NTDSPath = "C:\Windows\NTDS"
    #Patch Log
$LogPath = "C:\Windows\NTDS"
    #Sysvol Patch
$SysvolPath = "C:\Windows\SYSVOL"
    #Mode du domaine
$DomainMode = "Default"
    #Installation DNS
$InstallDNS = $true
    #Mode of forest
$ForestMode = "Default"
    #password admin security
$SafeModeClearPassword = Read-Host "Safe Mode Clear Password"
$SafeModeAdministratorPassword = ConvertTo-SecureString $SafeModeClearPassword -AsPlaintext -Force

#Installation De L'AD
Add-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools -IncludeAllSubFeature

#Installation de DNS
Add-WindowsFeature -Name DNS -IncludeManagementTools -IncludeAllSubFeature

Add-WindowsFeature -Name RSAT-AD-Tools -IncludeManagementTools -IncludeAllSubFeature

#creation delegation
Install-ADDSForest 
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
-Force:$true `
