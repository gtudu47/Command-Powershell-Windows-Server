# Import Module Active Dirctorie
Import-Module ActiveDirectory

$RNewUser = Read-Host "do you want to create a new User (yes or no)" 
while ($RNewUser -eq "yes" -or $RNewUser -eq "Yes" -or $RNewUser -eq "y" -or $RNewUser -eq "Y") {
    #Reset Variable
    $Part2User =  $Null
    #Name User
    $LastName = Read-Host -Prompt "Last Name"
    $FirstName = Read-Host -Prompt "First Name"
    $CompleteName = $FirstName + " " + $LastName
    #Domain Name
    $DomainName = Read-Host "Domain Name"
    #Name
    $UserPrincipalName = "$FirstName.$LastName@$DomainName"
    #PassWord
    $password = Read-Host -Prompt "password" -AsSecureString
    # Patch User
    $RPatchUser = Read-Host "how many OUs the user will be registered in"
    while ($RPatchUser -ge 1) {
        $RPatchUser = $RPatchUser -1
        $ParentUoUser = read-host "Parent OU"
        #Addition for creation patch
        $Part1User = "OU=" + $ParentUoUser
        if ($Part2User -eq $Null) {
            $Part2User = $Part1User
        } else {
            $Part2User = "$Part1User,$Part2User"
        }
    }
    Write-Host $Part2User

    #Domain Name for patch
    $DomainName1 = Read-Host "Name Domain Name (example : example)"     #Part 1
    $DomainName2 =Read-Host "Forest Domain Name (example : com)"        #Part 2
    $DomainNameUser = "DC=$DomainName1,DC=$DomainName2"    #assembly Domain Name
    #End Patch User
    $PatchUser = $Part2User +","+ $DomainNameUser                      #assmbly Patch OU
    # Create User
    New-ADUser -Name $CompleteName `
           -GivenName $FirstName `
           -Surname $LastName `
           -UserPrincipalName $UserPrincipalName `
           -AccountPassword $password `
           -Enabled $true `
           -Path $PatchUser `
           -ChangePasswordAtLogon $true
    
    $RNewUser = Read-Host "do you want to create a new User (yes or no)"
}