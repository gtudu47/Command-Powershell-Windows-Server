#Programm by frederic meunier
#For creation Unite Organisation (ADDS)

# Import the Active Directory module
Import-Module ActiveDirectory

#UO
$RNewUO = Read-Host "do you want to create a new UO (yes or no)"
if ($RNewUO -eq "yes" -or $RNewUO -eq "Yes" -or $RNewUO -eq "y" -or $RNewUO -eq "Y") {
    $RCreateUO = Read-Host "Create a UO root (1) or Create a UO inside UO (2)"
    if ($RCreateUO -eq 1) {
    # Name UO
        $NameUO = Read-Host "Name the UO"

    # Domain Name
        $DomainNameUO = Read-Host "Domain Name (example: DC=example,DC=com)"

    # Create a new Organizational Unit (OU)
        New-ADOrganizationalUnit -Name $NameUO -Path $DomainNameUO
    pause
    }elseif ($RCreateUO -eq 2) {
    # Name UO
        $NameUO = Read-Host "Name the UO"
    
    # Patch UO
        $ParentOU = read-host "Parent OU"
        $DomainNameUO = Read-Host "Domain Name (example: DC=example,DC=com)"
        $PatchOU = "OU=" + $ParentOU +","+ $DomainNameUO 
            
    # Create a new Organizational Unit (OU) inside another OU
        New-ADOrganizationalUnit -Name $NameUO -Path $PatchOU
        #Write-Host $NameUO $ParentOU  $DomainNameUO $PatchOU
        pause
    }
}
