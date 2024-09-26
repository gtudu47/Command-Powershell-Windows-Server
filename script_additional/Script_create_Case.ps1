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
        Write-Host "Le dossier $FinalPatch existe déjà."
    }

    # Attribuer des droits NTFS en contrôle total
    icacls $FinalPatch /grant "Administrateurs:F" /T
    icacls $FinalPatch /grant "UtilisateurSpécifique:F" /T

    # Attribuer des droits SMB
    $RNewShare = Read-Host "do you want to create a new Share (yes or no)" 
    while ($RNewShare -eq "yes" -or $RNewShare -eq "Yes" -or $RNewShare -eq "y" -or $RNewShare -eq "Y") {
    
        # Check if the share already exists
        if (-Not (Get-SmbShare -Name $NameCase -ErrorAction SilentlyContinue)) {
            # Create a Share SMB
            New-SmbShare -Name $NameCase -Path $FinalPatch -FullAccess "Everyone"

            # Attribuer des droits supplémentaires
            try {
                Grant-SmbShareAccess -Name $NameCase -AccountName "Everyone" -AccessRight Full
            } catch {
                Write-Host "Erreur lors de l'attribution des droits : $_"
            }
        } else {
            Write-Host "Le partage $NameCase existe déjà."
        }
        
        $RNewShare = Read-Host "do you want to create a new Share (yes or no)"
    }

    $RNewCase = Read-Host "do you want to create a new Case (yes or no)"
}
