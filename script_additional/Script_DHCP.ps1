#Programm by Frereric Meunier
#For DHCP service
$RDHCP = Read-Host "have you already installed the DHCP service (yes or No)"
if ($RDHCP -eq "no" -or $RDHCP -eq "No" -or $RDHCP -eq "n" -or $RDHCP -eq "N") {
# Install DHCP Service
    Install-WindowsFeature DHCP -IncludeManagementTools

# Ajouter le groupe de sécurité DHCP aux administrateurs locaux
    Add-DhcpServerSecurityGroup -ComputerName "NomDuServeurDHCP"

# Redémarrer le service DHCP
    Restart-Service DhcpServer

}



# Create extented
Write-Host "(Format : 0.0.0.0)"
#Name
$Name1 = Read-Host "Name of Scope"
#Start Range
$Start = Read-Host "Start Range"
#End Range
$End = Read-Host "End Range"
#Subnet Mask
$Subnet = Read-Host "Subnet Mask"
#Apply Settings
Add-DhcpServerv4Scope `
-Name $Name1 `
-StartRange $Start `
-EndRange $End `
-SubnetMask $Subnet `
-State Active

#Config option
Write-Host ""
#ScopeID
$ScopeID = Read-Host "ScopID"
#Router
$Router = Read-Host "Router (Default Gateway)"
#DNS Server
$DNSDHCP = Read-Host "DNS Server"

Set-DhcpServerv4OptionValue -ScopeId $ScopeID -Router $Router -DnsServer $DNSDHCP

# Activate extented
Set-DhcpServerv4Scope -ScopeId $ScopeID -State Active 
Write-Host $ScopeID "is activate"