#Programm by Frereric Meunier
#For creation case

$RNewCase = Read-Host "do you want to create a new User (yes or no)" 
while ($RNewCase -eq "yes" -or $RNewCase -eq "Yes" -or $RNewCase -eq "y" -or $RNewCase -eq "Y") {

#Patch case
$Patch = Read-Host "Patch for case (example : C:\User)"


$NameCase = Read-Host "Name a case (example : Administration)"

# Create case
New-Item -Path "$Patch\$NameCase" #-ItemType Directory
}