## To be run from Prod jump server ##
## !!Do not run Enable Oplocks portion with the rest of the script enabled!! ##

Import-Module NetApp.ONTAP

## CONNECTING TO CLUSTER ##

$CLUSTER      = "10.165.0.26"
$CLUSTER_USER = "admin"
$CLUSTER_PASS = Read-Host "Cluster Password" -AsSecureString

$clu_creds = New-Object System.Management.Automation.PsCredential($CLUSTER_USER,$CLUSTER_PASS)
[Void](Add-NcCredential -Name $CLUSTER -Credential $clu_creds)
Connect-NcController $CLUSTER -Credential $clu_cred -ZapiCall
## Get Volume and SVM ##
Get-NcVol #| Select *
## Get share properties, including oplocks not enabled ##
#Get-NcCifsShare | Select * | Select *
#Get-NcCifsShare | %{ 
#  if ($_.ShareProperties -notcontains "show_previous_versions" -and $_.ShareName -notin 'admin$','c$','ipc$') {
#        $_ | Set-NcCifsShare -ShareProperties ($_.ShareProperties += "show_previous_versions")
#    }
#}