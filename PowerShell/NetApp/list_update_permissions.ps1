## To be run from Prod jump server ##
## !!Do not run Enable Oplocks portion with the rest of the script enabled!! ##

#Import-Module NetApp.ONTAP

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
## Get Volume and SVM ##
Get-NcVol | Select-Object Name,State,Vserver #> L:\PowerShell\NetApp\Output\vserver_list.csv
## Get share properties ##
Get-NcCifsShare | Select * | Select Volume,Vserver,Sharename,ACL > L:\PowerShell\NetApp\Output\acl_list.csv
#Get-NaCifsShareAcl | Select * -ExpandProperty UserAclinfo > L:\PowerShell\NetApp\Output\acl_expanded.csv
Get-NcVserver *
get-nauser -Group Administrators
