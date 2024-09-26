#Programm by Frereric Meunier
#For creation case

$RNewCase = Read-Host "do you want to create a new Case (yes or no)" 
while ($RNewCase -eq "yes" -or $RNewCase -eq "Yes" -or $RNewCase -eq "y" -or $RNewCase -eq "Y") {

    #Patch case
    $Patch = Read-Host "Patch for case (example : C:\User)"

    $NameCase = Read-Host "Name a case (example : Administration)"
    $FinalPatch = "$Patch\$NameCase"

    # Create case
    if (-Not (Test-Path -Path $FinalPatch)) {
        New-Item -Path $FinalPatch -ItemType Directory
    } else {
        Write-Host "tth case $FinalPatch already exists."
    }

    #atribute a right SMB
    #$RNewShare = Read-Host "do you want to create a new Share (yes or no)" 
    #while ($RNewShare -eq "yes" -or $RNewShare -eq "Yes" -or $RNewShare -eq "y" -or $RNewShare -eq "Y") {
    
        # Create a Share SMB
    #    New-SmbShare -Name $NameCase -Path $Patch -FullAccess "Administrateurs" -ReadAccess "Utilisateurs"

        # Attribuer des droits supplémentaires
    #    Grant-SmbShareAccess -Name $NameCase -AccountName "UtilisateurSpécifique" -AccessRight Full
    #}

    $RNewCase = Read-Host "do you want to create a new User (yes or no)"
}
