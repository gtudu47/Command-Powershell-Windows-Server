#program by Frederic Meunier
#for installation of AD and DNS services

  #question for Rename Server
$RNewName = Read-Host "Do you want to change the server name(yes or No)"
if ($RNewName -eq "yes","Yes","y","Y") {
    #Rename Server
    $NewName = Read-Host "New Name for server"

    Rename-Computer -NewName $NewName

} elseif ($RNewName -eq "no","No","n","N") {
    Pause   
    #Values enter utlisateur
        #DNS Delegation
    $CreateDnsDelegation = $false
        #Domain Nametest
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
    $LogPath = Read-Host "Logs Path"
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
    Import-Module ADDSDeployment
    Install-ADDSForest `
    -CreateDnsDelegation $CreateDnsDelegation `
    -DomainName $DomainName `
    -DatabasePath $NTDSPath `
    #-DomainMode $DomainMode `
    #-DomainNetbiosName $NetbiosName `
    #-ForestMode $ForestMode `
    -InstallDNS:$InstallDNS `
    -LogPath $LogPath `
    -NoRebootOnCompletion:$false `
    -SysvolPath $SysvolPath `
    -SafeModeAdministratorPassword $SafeModeAdministratorPassword `
    -Force:$true
} else {

}
    Pause
    Restart-Computer
