###
# To run the script type the following in the Powershell CLI:
#
# ntapaddshareacl.ps1 -sharename  -ugname  -shareperms <no_access,full_control,read or change> -svmname 
# (.\ntapaddshareacl.ps1 -sharename test123 -ugname domain\user -shareperms reaad -svmname marctone
# The values will be passed into a for loop and add the users or groups listed in the ugname parameter to the command add-nccifsshareacl
# 
###

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


#$wmisvmuser = (gwmi win32_computersystem).username
#Connect-NcController $svmname -credential $wmisvmuser | out-null

#Add-NcCifsShareAcl -Share test_share -UserOrGroup 'sigi\s-rubrik' -Permission full_control -VserverContext test-nas01-tmp

## Get share properties ##
#Get-NcCifsShare | Select * | Select Volume,Vserver,Sharename,Acl > L:\PowerShell\NetApp\Output\share_perms.csv
#Get-NcCifsShare | Select * | Select Volume,Vserver,Sharename,Oplocks | Select-String False #> L:\PowerShell\NetApp\Output\share_perms.csv

## Add user ##
$Items = Import-Csv L:\PowerShell\NetApp\Output\share_perms2.csv
foreach ($Item in $Items)
{
Add-NcCifsShareAcl $Item.sharename -VserverContext $item.svmname -UserOrGroup sigi\s-rubrik -Permission full_control
#add-nccifsshareacl -share test_share -gname sigi\s-rubrik -shareperms full_control -svmname test-nas01-tmp
}