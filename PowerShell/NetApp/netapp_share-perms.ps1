## To be run from Prod jump server ##
## !!Do not run Enable Oplocks portion with the rest of the script enabled!! ##

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
$vserver = $($Item.vserver)

Connect-NcController $CLUSTER -Credential $clu_cred
#Get-NcCifsShare | select Vserver,ShareName,ACL > L:\PowerShell\NetApp\Output\share_properties.csv,Path | where path -notlike "/" > L:\PowerShell\NetApp\Output\share_properties.csv #| % {Get-NcFileDirectorySecurity -Path $_.Path -VserverContext $_.Vserver | where SecurityStyle -eq "ntfs"}
#Get-NcCifsShare | select Volume,Vserver,ShareName,ACL | Export-Csv -Path L:\PowerShell\NetApp\Output\csv_share_properties.csv
Get-NcCifsShareAcl | select Volume,Vserver,Share,UserorGroup,Permission | Export-Csv -Path L:\PowerShell\NetApp\Output\share_acls.csv #> L:\PowerShell\NetApp\Output\share_properties.csv




## Get Volume and SVM ##
#Get-NcVol | Select-Object Name,State,Vserver > L:\PowerShell\NetApp\Output\vserver_list.csv
## Get share properties, including oplocks not enabled ##
#Get-NcCifsShare | Select * | Select Volume,Vserver,Sharename,Acl,Oplocks | Select-String False > L:\PowerShell\NetApp\Output\share_properties_false.csv

## Enable Oplocks ##
#$Items = Import-Csv L:\PowerShell\NetApp\Output\share_properties_false1.csv
#ForEach ($Item in $Items){

#set-Nccifsshare $($Item.sharename) -VserverContext $($Item.vserver) -ShareProperties Oplocks -ZapiCall

#}