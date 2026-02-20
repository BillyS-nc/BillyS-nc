## To be run from Prod jump server ##

Import-Module NetApp.ONTAP

## CONNECTING TO CLUSTER ##

$CLUSTER      = "10.165.0.26"
$CLUSTER_USER = "admin"
$CLUSTER_PASS = Read-Host "Cluster Password" -AsSecureString

$clu_creds = New-Object System.Management.Automation.PsCredential($CLUSTER_USER,$CLUSTER_PASS)
[Void](Add-NcCredential -Name $CLUSTER -Credential $clu_creds)
Connect-NcController $CLUSTER

## option parameters ##
$share = $($Item.sharename)
$volume = $($Item.volume)
$vserver = $($Item.vserver)

Connect-NcController $CLUSTER -Credential $clu_cred
Get-NcCifsShare | select Vserver,volume > L:\PowerShell\NetApp\Output\file_count.csv

## Get file count ##
ForEach ($Item in $Items){

volume show -vserver $($Item.vserver) -volume $($Item.volume) -fields files-used

}
