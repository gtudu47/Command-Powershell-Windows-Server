#Programm by frederic meunier
#For creation Unite Organisation (ADDS)

# Import the Active Directory module
Import-Module ActiveDirectory

#UO
$RNewUO = Read-Host "do you want to create a new UO (yes or no)" 
while ($RNewUO -eq "yes" -or $RNewUO -eq "Yes" -or $RNewUO -eq "y" -or $RNewUO -eq "Y") {
    $RCreateUO = Read-Host "Create a UO root (1) or Create a UO inside UO (2)"
    if ($RCreateUO -eq 1) {
    # Name UO
        $NameUO = Read-Host "Name the UO"

    # Domain Name
        $DomainName1 = Read-Host "Name Domain Name (example : example)" #Part1
        $DomainName2 =Read-Host "Forest Domain Name (example : com)"    #Part2
        $DomainNameUO = "DC=" + $DomainName1 +","+ "DC=" +$DomainName2  #assembly Domain Name

    # Create a new Organizational Unit (OU)
        New-ADOrganizationalUnit -Name $NameUO -Path $DomainNameUO
    pause
    }elseif ($RCreateUO -eq 2) {
    # Name UO
        $NameUO = Read-Host "Name the UO"
    
    # Patch UO
        $ParentOU = read-host "Parent OU"                               #Parent UO
        $DomainName1 = Read-Host "Name Domain Name (example : example)" #Part 1
        $DomainName2 =Read-Host "Forest Domain Name (example : com)"    #Part 2
        $DomainNameUO = "DC=" + $DomainName1 +","+ "DC=" +$DomainName2  #assembly Domain Name
        $PatchOU = "OU=" + $ParentOU +","+ $DomainNameUO                #assmbly Patch OU
            
    # Create a new Organizational Unit (OU) inside another OU
        New-ADOrganizationalUnit -Name $NameUO -Path $PatchOU
        pause
    }
$RNewUO = Read-Host "do you want to create a new UO (yes or no)"
}
